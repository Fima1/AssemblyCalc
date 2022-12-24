# AssemblyCalc
Calculator program capable of numeric, string, list and array operations written in Assembly x86.
```
	#
	# SIMPLE COMMANDS
	#
	#  For simple commands, the first byte of the 8-byte command is one of:
	#    '&', '|', 'S', 'a', 'l', 'U', 'I'
	#  In these cases the remaining 7 bytes are padding and should be ignored.
	#  The next 8 bytes are the single argument to the simple command.  'a' command takes
	#  an additional 8 byte command as described below.
	#  The following describes what your program should do to process each of the simple
	#  commands:
	#
	#    '&'  :  AND: Takes one argument: update rax with the bitwise and of the
	#         :  current value of rax and the argument
	#         :  value eg.  rax = rax bitwise and with the 8-byte argument value
	#	  :
	#    '|'  :  OR: Takes one argument: same as above but apply bitwise or.
	#	  :
	#    'S'  :  SUM: Takes one argument: your sum routine should both 
	#         :       update rax by summing the value into rax, and update either
	#         :       the global "positive" or "negative" sum as needed.
	#	  :
	#    'a'  :  ARRAYSUM: Takes two 8-byte arguments:  First is a length, and
	#         :            the second is an 8-byte address to an array of 8-byte values.
	#         :            You should apply the sum operator to each value in the array.
	#	  :
	#    'l'  :  LISTSUM:  Takes one argument: The argument is an 8-byte address of
	#         :            a list of values.  You should iterate over the list and
	#         :            apply the sum operator to the values.  Each list element is 
	#         :            16 bytes.  The first 8 bytes is the value in the element.
	#         :            The next 8 bytes is an address that points to the next
	#         :            element in the list.  You should treat a 0 address to
	#         :            indicate the end of the list.
	#	  :
	#    'U'  :  UPPER: The second argument should be treated as a pointer to
	#         :         an ascii string (a sequence of non-zero bytes terminated 
	#         :         by a zero valued byte) eg 'a''b''c'0x0.  This command 
	#         :         should process the string converting lowercase letters
	#         :         ('a' - 'z') to their corresponding uppercase letter
	#         :         'A' - 'Z'.  The routine should also add the length of
	#         :         the string to rax. Note if the first byte of the string
	#         :         is zero then the string length is 0.  The length of
	#         :         'a'0x0 would be 1 and so on.
	#	  :
	#    'I'  : ATOQ:  The second argument should be treated as a pointer to an ascii
	#         :        string.  This string should be converted to a signed 8-byte
	#         :        value.  The converted value should be summed in rax and,
	#         :        like in the sum command, the SUM_POSITIVE and SUM_NEGATIVE should be updated correctly
	#
	# 
	# When you encounter a 0 byte as the command type you should stop processing commands.

	# COMPLEX COMMANDS
	#
	#
	#
	# 'A' :  ARRAY:  indicates that the next byte of the command type value will be one of the
	#                following simple command characters '&','|','S' or 'U'
	#     eg.  'A''&' or 'A''|' or 'A''S' or 'A''U'.  The remaining 6 bytes of the command type
	#     value should be skipped.  The array command takes two 8-byte arguments that follow the type
	#     value.  The first is a Length value and the next is the address of an Array of values.
	#     Your code needs to run the specified simple command on each 8-byte value in the Array.
	#     The length specifies the number of items in the Array
	#
	# 'L' : LIST:  Like Array, the next byte of the command type value will be one of the
	#              following simple command characters '&','|','S' or 'U'
	#     eg.  'L''&' or 'L''|' or 'L''S' or 'L''U'.  The remaining 6 bytes of the command type
	#     value should be skipped.  List command takes one 8-byte argument that follows the type value.
	#     The argument should be treated as a pointer to a "list" of arguments (if zero then the list is empty).
	#     Assuming a non-empty list your code should process
	#     each element of the list by applying the specified operator to the value in each list element.
	#     The structure of a list element is as follows:
	#       <8 byte value for operation><8 byte address of next list element>
        #     The end of the list is denoted by a 0 value for the next list element.
```
