calc_basic: calc.o data/basic_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/basic_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_basic
calc_upperonly: calc.o data/upperonly_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/upperonly_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_upperonly
calc_basicwithupper: calc.o data/basicwithupper_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/basicwithupper_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_basicwithupper
calc_simpleone: calc.o data/simpleone_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/simpleone_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_simpleone
calc_simplerandom: calc.o data/simplerandom_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/simplerandom_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_simplerandom
calc_easy: calc.o data/easy_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/easy_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_easy
calc_arraysum: calc.o data/arraysum_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/arraysum_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_arraysum
calc_listsum: calc.o data/listsum_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/listsum_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_listsum
calc_array: calc.o data/array_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/array_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_array
calc_list: calc.o data/list_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/list_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_list
calc_atoq: calc.o data/atoq_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o
	ld -g calc.o data/atoq_cmds.o and.o or.o sum.o upper.o arraysum.o listsum.o array.o list.o atoq.o -o calc_atoq
calc.o: calc.s
	as -g  calc.s -o calc.o
data/basic_cmds.o: data/basic_cmds.s
	as -g  data/basic_cmds.s -o data/basic_cmds.o
data/upperonly_cmds.o: data/upperonly_cmds.s
	as -g data/upperonly_cmds.s -o data/upperonly_cmds.o
data/basicwithupper_cmds.o: data/basicwithupper_cmds.s
	as -g data/basicwithupper_cmds.s -o data/basicwithupper_cmds.o
data/simpleone_cmds.o: data/simpleone_cmds.s
	as -g data/simpleone_cmds.s -o data/simpleone_cmds.o
data/simplerandom_cmds.o: data/simplerandom_cmds.s
	as -g data/simplerandom_cmds.s -o data/simplerandom_cmds.o
data/easy_cmds.o: data/easy_cmds.s
	as -g data/easy_cmds.s -o data/easy_cmds.o
data/arraysum_cmds.o: data/arraysum_cmds.s
	as -g data/arraysum_cmds.s -o data/arraysum_cmds.o
data/listsum_cmds.o: data/listsum_cmds.s
	as -g data/listsum_cmds.s -o data/listsum_cmds.o
data/array_cmds.o: data/array_cmds.s
	as -g data/array_cmds.s -o data/array_cmds.o
data/list_cmds.o: data/list_cmds.s
	as -g data/list_cmds.s -o data/list_cmds.o
data/atoq_cmds.o: data/atoq_cmds.s
	as -g data/atoq_cmds.s -o data/atoq_cmds.o
and.o: and.s
	as -g and.s -o and.o
or.o: or.s
	as -g or.s -o or.o
sum.o: sum.s
	as -g sum.s -o sum.o
upper.o: upper.s
	as -g upper.s -o upper.o
arraysum.o: arraysum.s
	as -g arraysum.s -o arraysum.o
listsum.o: listsum.s
	as -g listsum.s -o listsum.o
array.o: array.s
	as -g array.s -o array.o
list.o: list.s
	as -g list.s -o list.o
atoq.o: atoq.s
	as -g atoq.s -o atoq.o
