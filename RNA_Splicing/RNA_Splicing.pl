#给定DNA和内含子，输出蛋白质
#调用了之前的RNA转蛋白质脚本但并未改动，新代码只包含在该文件中
use strict;
use feature qw/state/;
open IN,my $name=shift;
open OUT,">",$name.=".temp";
my (@fasta, $first_seq);
while(<IN>){#数据为fasta格式，第一条序列是目标序列，以后均为内含子
	chomp;state $control;
	if(/^>/){
		$control++;#计数，区分查询序列和内含子序列
		next;
	}elsif($control==1){
		$first_seq .= $_;
	}elsif($control>1){
		push @fasta, $_;
	}
}
foreach(0..$#fasta){#删除内含子，
	$first_seq =~ s/$fasta[$_]//;
	#print "$fasta[$_]\n";
}
$first_seq =~ tr/T/U/;#之前的脚本是RNA的，因此转换一下
print OUT"$first_seq\n";
system "perl Trans_RNA2Protein.pl $name";