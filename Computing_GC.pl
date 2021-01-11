#统计fasta格式文件中，每条序列的GC含量，并输出GC含量最大的序列和含量
#支持fasta格式文件序列非单行
open IN,shift;
while(<IN>){
	chomp;
	if(/>(.+?)/){
		$name = $_;
		next;
	}
	$seq{$name}.=$_
}
for(sort keys %seq){
	$GC = ($seq{$_}=~tr/GC/GC/);
	$count = $GC/length($seq{$_})*100;
	if($count > $Rcount){
		$Rname = $_;
		$Rcount = $count;
	}
}
print "$Rname\t$Rcount\n";