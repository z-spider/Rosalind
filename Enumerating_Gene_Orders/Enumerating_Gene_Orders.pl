use strict;
use 5.010;
open IN,my $name=shift;
open OUT,">$name.out";
#提供一个数字n作为参数,返回从1到n的全排列
our sub perm{
	my @list = @_;
	my @kk;
	if($#list==0){
		return @list;
	}
	elsif($#list==1){#终止递归
		return (@list[0].@list[1], @list[1].@list[0]);
	}
	for(0..$#list){
		my @nlst = @list;
		splice (@nlst, $_, 1);#除了lst[i]以外的元素
		my @c = &perm(@nlst);#递求剩下元素的全排列,返回两个元素
		my $i = $_;
		foreach(@c){#把终止条件后连接上元素i
			$_=$list[$i].$_ if($_!=undef);
		}
		splice (@kk, 1, 0, @c);#将C存入数组
	}
	return @kk;#返回不同i的
}
#执行
my $n = <IN>;
my @result = &perm(1..$n);#提供一个数字作为参数
print OUT $#result+1,"\n";
foreach(@result){
	my @temp = split '', $_;
	print OUT"@temp\n";
}