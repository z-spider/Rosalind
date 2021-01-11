#用动态规划算法实现
#rosalind算法题目的斐波那契数列
$n = shift;
$k = shift;
@memo = (1,1);#初始化数组，斐波那契数列前两个值是1,1

sub fib{
	my ($n,$k) = (shift,shift);
	if( $n <= 1 ){#角标小于1的时候不做计算
		return 1;
	}
	else{#当数组不存在需要值的时候，调用子程序计算
		if(@memo[$n-1] == 0){
			@memo[$n-1] = &fib($n-1,$k);
		}
		if(@memo[$n-2] == 0){
			@memo[$n-2] = &fib($n-2,$k);
		}
	}
	@memo[$n] = @memo[$n-1] + ($k * @memo[$n-2]);#状态转移方程
	return @memo[$n];

}
	print &fib($n-1,$k);#数组从0开始计算，因此角标[n-1]记录的就是第n次计算的值了
