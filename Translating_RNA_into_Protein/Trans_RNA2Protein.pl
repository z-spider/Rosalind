#根据密码子，将RNA转化为蛋白质
#注意该文件保留了stop的输出，而rosalind的答案中不允许有stop
open IN,"RNA_code_table.txt";#密码子文件
open SEQ,$name=shift;#输入的序列
open OUT,">$name.out";
while(<IN>){#密码子表
	chomp;
	while(/(\w{3}) (\w+)/g){
		$code{$1}=$2;
	}
}
$seq = <SEQ>;#需要转换的序列
while($i<length($seq)){#转化
	$transing = substr($seq,$i,3);
	print OUT"$code{$transing}";
	$i+=3;
}