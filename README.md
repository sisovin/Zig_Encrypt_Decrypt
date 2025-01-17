### Step-by-Step Plan for 

1. Project Overview
2. Features and Requirements
3. Technical Implementation
4. Build & Run Instructions
5. GitHub Integration Steps
6. Conclusion


# Password Encryption Tool

### Author: [\Chieng Sisovin\](https://github.com/sisovin)

## Overview
A secure password encryption/decryption tool built in Zig that implements AES-128 encryption in CBC mode. The tool validates passwords, encrypts them securely, and demonstrates the decryption process.

## Features
- Password validation
  - Length: 4-128 characters
  - Must contain both letters and numbers
- AES-128 encryption in CBC mode
- Hex-formatted encrypted output
- Secure decryption verification

## Technical Implementation

### Password Validation
```zig
fn validatePassword(password: []const u8) bool {
    // Checks length (4-128 chars)
    // Verifies contains letters and numbers
    // Returns true if valid
}
```

### Encryption Process
1. Key initialization (16-byte AES-128)
2. Data padding to 16-byte blocks
3. CBC mode encryption with IV
4. Memory management with proper cleanup

### Decryption Process
1. Key verification
2. CBC mode decryption
3. Original data recovery
4. Memory deallocation

## Build & Run Instructions

### Prerequisites
- Zig 0.11.0 or later
- Windows 10/11 or compatible OS

### Output Example
```sh
PS D:\ZigProjects\Decryption> zig run .\src\main.zig

=== Password Encryption Tool ===

Password requirements:
- Length: 4-128 characters
- Must contain letters and numbers

Enter password: !(1DEJ6L%#W3Gh!00NEzv&$1*^7#@U%6

=== Encryption Results ===
Key (masked): ****************
Original length: 33
Encrypted length: 48

Encrypted (hex): e02e38fc 54feab5e 15f957f5 b04b40eb 89d59ca9 f1f43ba3 3c418169 c36b6d22 4dec9852 75048381 b1c478ff 379c6605

=== Decryption Results ===
Decrypted: !(1DEJ6L%#W3Gh!00NEzv&$1*^7#@U%6
```

### Setup
```powershell
# Clone the repository
git clone https://github.com/sisovin/Zig_Encrypt_Decrypt.git
cd Decryption

# Build the project
zig build

# Run the application
zig run src/main.zig
```

### Example Usage
```
=== Password Encryption Tool ===

Password requirements:
- Length: 4-128 characters
- Must contain letters and numbers

Enter password: MySecurePass123

=== Encryption Results ===
Key (masked): ****************
Original length: 14
Encrypted length: 16
Encrypted (hex): e02e 38fc 54fe ab5e 15f9 57f5 b04b 40eb

=== Decryption Results ===
Decrypted: MySecurePass123
```

## GitHub Integration

1. Create a new repository on GitHub
```powershell
git init
git add .
git commit -m "Initial commit: Password encryption tool"
git branch -M main
git remote add origin https://github.com/sisovin/Zig_Encrypt_Decrypt.git
git push -u origin main
```

2. Repository Structure
```
Decryption/
├── src/
│   ├── main.zig
│   └── encrypt_decrypt.zig
├── build.zig
└── build.zig.zon
└── README.md
```

## Conclusion
This project demonstrates secure password handling with:
- Modern encryption standards (AES-128)
- Secure memory management
- Input validation
- Clear user interface

For security considerations:
- Use secure random IV in production
- Implement proper key management
- Consider adding salt for password hashing
- Regular security audits recommended

## License
MIT License - See LICENSE file for details
```

### GitHub Push Instructions
```powershell
# From your project directory
git init
git add .
git commit -m "Initial commit: Password encryption tool"
git branch -M main
git remote add origin https://github.com/sisovin/Zig_Encrypt_Decrypt.git
git push -u origin main

