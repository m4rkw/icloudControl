//
//  main.swift
//  icloudControl
//
//  Created by mark on 20/10/2017.
//  Copyright © 2017 mark. All rights reserved.
//

import Foundation

if CommandLine.arguments.count < 3 {
    print("Usage: \(CommandLine.arguments[0]) [offload|restore] <path>")
    exit(0)
}

let fm = FileManager.default

var isDir : ObjCBool = false

fm.fileExists(atPath:CommandLine.arguments[2], isDirectory:&isDir)

let url = URL.init(fileURLWithPath: CommandLine.arguments[2], isDirectory: isDir.boolValue)

if CommandLine.arguments[1] == "offload" {
  do {
    try fm.evictUbiquitousItem(at: url)
    print("path offloaded.")
  } catch {
    print("failed: \(error)")
  }
}

if CommandLine.arguments[1] == "restore" {
  do {
    try fm.startDownloadingUbiquitousItem(at: url)
    print("path restored.")
  } catch {
    print("failed: \(error)")
  }
}

