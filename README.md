# Driver Helper

A tool to help you write the code use to manipulate the register in a device.

## Use case

Some devices have a lot of registers and in those registers multiples fields. If you write the name, address, size and offset of those fields in a CSV file, this tool will write macros used to manipulates those fields.

## Input file

The input file should be a CSV file. Here is an example of possible content:

| Name        | Address | Offset | Size |
|-------------|---------|--------|------|
| FIFO\_FLAG  | 0       | 0      | 2    |
| FIFO\_SIZE  | 0       | 2      | 6    |
| DATA\_INPUT | 1       | 0      | 8    |

There is multiple things to take into account:
* The order of the columns does not matter but their names should be respected and written in the fist line.
* The address should be written in hexadecimal with no prefix.

## Output file

The tool will generate a C header file containing macros defining the information in the input file. For example for the `FIFO_FLAG` entry, the following macros will be defined.

 ```
#define FIFO_FLAG_ADDR   0
#define FIFO_FLAG_OFFSET 0
#define FIFO_FLAG_SIZE   2
```

Furthermore, the function-like macro `FIELD_READ(field_name)` and `FIELD_WRITE(field_name, data)` will be defined. They depends on the functions `_register_read(address)` and `_register_write(address, data)`. The two later should be defined by the user.

## Usage

The usage of the tool is the following: 

```
xxx <input file> <output file>
```

