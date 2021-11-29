H = 4
W = 4
block_size = 8


block_num = block_size-1
dist_nxt_height = H*block_size
max_addr = 2+H*W*8+8
min_addr = 2
begin_addr = 2
height = H-1
width = W-1
a = 0
x = 0
y = 0

loop_num = 1
state = 0
state_maxp = 0
flag_end = False

now_addr = begin_addr

def clamp(addr):
	return addr-max_addr+min_addr if addr>=max_addr else addr


def nxt():
	global a, block_num, x, y, height, now_addr
	if(a==block_num):
		y = (y+1 if x==height else y)
		x = (0 if x==height else x+1)
	a = (0 if a==block_num else a+1)
	now_addr = clamp(now_addr+1)
	return now_addr


def nxt_cycle():
	global a, block_num, x, y, height, now_addr
	print("a:", a, " state:", state);
	now_addr = clamp(now_addr-block_num if a==block_num else now_addr+1)
	a = (0 if a==block_num else a+1)
	return now_addr


def gen_conv():
	global flag_end, x, y, width, height, a, block_num, state, loop_num
	flag_end = flag_end or (x==width and y==height and a==block_num and state==loop_num)
	sstate = state
	state = (0 if sstate==loop_num and a==block_num else (state+1 if a==block_num else state))
	ret = (nxt() if sstate==loop_num and a==block_num else nxt_cycle())
	return ret


while(not flag_end):
	print(gen_conv())
