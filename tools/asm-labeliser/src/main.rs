use std::cmp::min;
use regex::Regex;
use std::io::prelude::*;
use std::fs::File;
use std::io::{BufRead, BufReader, BufWriter, Result, SeekFrom};
use std::collections::HashSet;

fn cleanup_instruction(instruction: &str) -> String {
    let mut parts = instruction.split_ascii_whitespace().collect::<Vec<&str>>();
    let opcode = parts.remove(0);
    let mut operands = "".to_string();

    let mut comment = false;
    while parts.len() > 0 {
        let part = parts.remove(0);
        if part.starts_with(";") {
            comment = true;
            break;
        }
        operands.push_str(part)
    }
    let mut comment_str = "".to_string();
    if comment {
        comment_str.push(';');
        for part in parts {
            comment_str.push(' ');
            comment_str.push_str(part);
        }
    }
    let new_instruction = format!("{:6}{:10}{}", opcode, operands, comment_str);
    new_instruction.to_string()
}

fn get_comment(file: &mut File, address: &str) -> Option<String> {
    let mut result = None;
    print!("trying: {}", address);
    file.seek(SeekFrom::Start(0));
    for line in BufReader::new(file).lines() {
        let line = line.unwrap();
        if line.starts_with(address) && line.contains(";") {
            let parts = line.split(";").collect::<Vec<&str>>();
            if parts.len() == 2 {
                result = Some(parts[1].to_string());
            }
            println!("FOUND comment: {:?}", result);
        }
    }
    result
}

fn main() -> Result<()> {
    let mut labels:HashSet<String> = HashSet::new();

    //println!("cleanup: {}", cleanup_instruction("LXI D,FC18H    ; Start of FAC1 for single and double precision"));
    let mut merge_file = File::open("../RomT102Disassembly/m100_dis_merged.txt").unwrap();
    // get_comment(&merge_file, "0F23H");
    // return Ok(());

    let re = Regex::new(r".[0-7][0-9A-F][0-9A-F][0-9A-F]H").unwrap();
    {
    let file = File::open("../RomT102Disassembly/OSROMT102.asm85")?;
    let mut out_file = File::create("phase_one_asm.asm85")?;
    for line in BufReader::new(file).lines() {
        if let Ok(line) = line {
            let mat = re.find(&line);
            let mut new_line = if let Some(address) = mat {
                let address = &address.as_str()[1..];
                let labeled = line.as_str().replace(address, format!("L{}", address).as_str());
                &labels.insert(address.to_string());
                labeled
            } else {
                line.to_string()
            };
            if !line.starts_with(" ") && !line.as_str()[0..min(10, line.len())].contains(":") && line.len()>5  && !line.contains(";"){
                if let Some(new_comment) = get_comment(&mut merge_file, &line.as_str()[0..5]) {
                    new_line = format!("{:24}\t;{}", new_line, new_comment);
                }
            }
            out_file.write(new_line.as_bytes())?;
            out_file.write(b"\n")?;
        }
    }
    }
    let mut final_file = File::create("labeled_asm.asm85")?;

    let file = File::open("phase_one_asm.asm85")?;

    for line in BufReader::new(file).lines() {
        if let Ok(line) = line {
            let line_address = line.as_str()[0..min(5, line.len())].to_string();
            if line.starts_with(';') || line.starts_with('\t') || line.starts_with(" ") || line.starts_with("L") || line.as_str()[0..min(10, line.len())].contains(":") {
                final_file.write(line.as_bytes())?;
                final_file.write(b"\n")?;
                continue
            }
            let instruction = if line.len() > 13 && !(line.contains(" DW ") || line.contains(" DB ")) { 
                format!("\t{}", cleanup_instruction(&line.as_str()[13..]))
            } else if line.contains(" DW ") {
                format!("DW\t{}", cleanup_instruction(&line.as_str()[12..]))
            } else if line.contains(" DB ") {
                format!("DB\t{}", cleanup_instruction(&line.as_str()[12..]))
            } else {
                line.to_string()
            };
            if labels.remove(&line_address) {
                //println!("FOUND: {}", line_address);
                let new_line = format!("L{}:{}", line_address, instruction);
                final_file.write(new_line.as_bytes())?;
                final_file.write(b"\n")?;
            } else {
                final_file.write(b"\t")?;
                final_file.write(instruction.as_bytes())?;
                final_file.write(b"\n")?;
            }
        }
    }
    
    Ok(())
}
