const std = @import("std");
const Aes128 = std.crypto.core.aes.Aes128;

pub fn encrypt(data: []const u8, key: []const u8) ![]u8 {
    // Convert key slice to fixed-size array
    var key_bytes: [16]u8 = undefined;
    @memcpy(&key_bytes, key[0..16]);

    var aes = Aes128.initEnc(key_bytes);
    const iv = [_]u8{0} ** 16;

    const padded_len = (data.len + 15) & ~@as(usize, 15);
    const ciphertext = try std.heap.page_allocator.alloc(u8, padded_len);

    // Pad data
    @memcpy(ciphertext[0..data.len], data);
    if (padded_len > data.len) {
        @memset(ciphertext[data.len..], 0);
    }

    var block: [16]u8 = undefined;
    var prev = iv;

    var i: usize = 0;
    while (i < padded_len) : (i += 16) {
        for (0..16) |j| {
            block[j] = ciphertext[i + j] ^ prev[j];
        }
        aes.encrypt(&prev, &block);
        @memcpy(ciphertext[i..][0..16], &prev);
    }

    return ciphertext;
}

pub fn decrypt(ciphertext: []const u8, key: []const u8) ![]u8 {
    // Convert key slice to fixed-size array
    var key_bytes: [16]u8 = undefined;
    @memcpy(&key_bytes, key[0..16]);

    var aes = Aes128.initDec(key_bytes);
    const iv = [_]u8{0} ** 16;

    const plaintext = try std.heap.page_allocator.alloc(u8, ciphertext.len);

    var block: [16]u8 = undefined;
    var prev = iv;

    var i: usize = 0;
    while (i < ciphertext.len) : (i += 16) {
        const cipher_block = ciphertext[i..][0..16].*;
        aes.decrypt(&block, &cipher_block);
        for (0..16) |j| {
            plaintext[i + j] = block[j] ^ prev[j];
        }
        prev = cipher_block;
    }

    return plaintext;
}
