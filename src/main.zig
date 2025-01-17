// Program: Password Encryption Tool
//
// Descriptions are the following:
// - Password validation
//  - Length: 4-128 characters
//  - Must contain both letters and numbers
// - AES-128 encryption in CBC mode
// - Hex-formatted encrypted output
// - Secure decryption verification
//
// Author: [\Chieng Sisovin\](https://github.com/sisovin)
// Date: 2025-01-17

const std = @import("std");
const encryption = @import("encrypt_decrypt.zig");

fn validatePassword(password: []const u8) bool {
    if (password.len < 4 or password.len > 128) return false;

    var has_letter = false;
    var has_number = false;

    for (password) |char| {
        if (std.ascii.isAlphabetic(char)) has_letter = true;
        if (std.ascii.isDigit(char)) has_number = true;
    }

    return has_letter and has_number;
}

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();
    const stdin = std.io.getStdIn().reader();

    try stdout.print("\n=== Password Encryption Tool ===\n\n", .{});
    try stdout.print("Password requirements:\n", .{});
    try stdout.print("- Length: 4-128 characters\n", .{});
    try stdout.print("- Must contain letters and numbers\n", .{});
    try stdout.print("\nEnter password: ", .{});

    var password_buffer: [128]u8 = undefined;
    const password = try stdin.readUntilDelimiter(&password_buffer, '\n');

    if (!validatePassword(password)) {
        try stdout.print("\nError: Password does not meet requirements!\n", .{});
        return;
    }

    const key = "0123456789abcdef";
    const encrypted = try encryption.encrypt(password, key);
    defer std.heap.page_allocator.free(encrypted);

    try stdout.print("\n=== Encryption Results ===\n", .{});
    try stdout.print("Key (masked): ****************\n", .{});
    try stdout.print("Original length: {d}\n", .{password.len});
    try stdout.print("Encrypted length: {d}\n", .{encrypted.len});
    try stdout.print("\nEncrypted (hex): ", .{});

    // Print hex in blocks of 4 bytes
    for (encrypted, 0..) |byte, i| {
        if (i > 0 and i % 4 == 0) try stdout.print(" ", .{});
        try stdout.print("{x:0>2}", .{byte});
    }

    const decrypted = try encryption.decrypt(encrypted, key);
    defer std.heap.page_allocator.free(decrypted);

    try stdout.print("\n\n=== Decryption Results ===\n", .{});
    try stdout.print("Decrypted: {s}\n", .{decrypted[0..password.len]});
}
