#下载蛋白质序列并从中查找某个motif
#http://rosalind.info/problems/mprt/
use 5.010;
use strict;
open IN,my $name = shift;
open TEMP,">",my $name_temp = $name.".temp";#用于wget下载的临时文件
open OUT,">",$name.".out";
my @handle;
# 下载蛋白质文件
while(<IN>){
	local $/ = "\r\n";#rosalind下载的是windows格式换行符\r\n。
	chomp;
	push @handle, $_;
	print TEMP "http://www.uniprot.org/uniprot/$_.fasta\n";
}
system "proxychains wget -nv -N -i  $name_temp -P ./data/" ;#也可以在循环中下载
#-nv关闭详尽输出，-N只获取比本地文件新的文件 -i指定网址文件 -P指定下载目录
system "rm $name_temp";

# 读取并处理蛋白质文件
for my $HANDLE(@handle){
	open my $fh,"./data/$HANDLE.fasta"
		or die "Can't open $HANDLE.fasta: $!";#用匿名引用的原因见https://perldoc.perl.org/functions/open
	my ($fasta);#存储序列
	{#读取文件并删除标题行和换行符
		local $/;#分隔符定义为undef
		$fasta = <$fh>;
		$fasta =~ s/>.+?\n|\n//g;
	}
	state $first;$first = 0;#在第一次匹配前输出access ID作为标记
	while($fasta =~ /(N[^P][ST][^P])/g){#查找并输出位置
		if($first == 0){
			print OUT"$HANDLE\n";
			$first = 1;
		}
		my $position = pos($fasta)-3;#起始位置
		print OUT"$position ";
		pos($fasta) = $position;#向前重新定位，以查找重叠motif
	}
	print OUT"\n" if($first==1);#在查找完后换行
}