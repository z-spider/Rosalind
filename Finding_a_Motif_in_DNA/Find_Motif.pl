#寻找DNA中的motif
open IN,$name=shift;#密码子文件
chomp(($seq, $motif)=<IN>);
#print $seq,"\n",$motif,"\n";
#寻找motif, 其中(?=EXP)指的是零宽度正预测先行断言，(?!EXP)对应的是负预测
while($seq =~ /(?=$motif)/g){
	print pos($seq)+1," ";
}