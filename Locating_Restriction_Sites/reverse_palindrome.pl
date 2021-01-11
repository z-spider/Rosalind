#以O(n^2)的复杂度寻找反向回文序列，可以用manacher算法优化成O(n)
open IN,shift;
open OUT,">out.out";
#提供的fasta文件并非一行#($firstline,$seq) = <IN>;
while(<IN>){
	chomp;
	next if(/>/);
	$seq.=$_;
}
foreach (1..length($seq)){
	my $i = $_;
	foreach $j ($i+3..length($seq)){
		$length = $j-$i+1;
		if($length<=12){
			$subseq = substr($seq, $i-1, $length),"\n";#所有的子序列
			$rc_subseq = reverse($subseq);
			$rc_subseq =~ tr/ATGC/TACG/;#反向互补子序列
			if($rc_subseq eq $subseq){
				print OUT "$subseq\t$rc_subseq\t",$i," ",$length,"\n";
				print $i," ",$length,"\n";
			}
		}
	}
}