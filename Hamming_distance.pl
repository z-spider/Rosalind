#rosalind: 给出两条序列，计算二者之间的汉明距离
use utf8;
#use strict;#不好用
open IN,shift;
chomp(my($s, $t) = <IN>);#只取文件的前两行
#chomp(my ($s, $t) = (shift, shift));从命令行参数输入
my @s = split(//, $s);
my @t = split(//, $t);
my $count;
while(my($i, $value) = each @s){
#print "$t[0]";
	if($value ne $t[$i]){
		print "$value$t[$i] ",$i+1,"\t";#输出差异点和位置
		$count++;
	}
}

print "\n",$count;
