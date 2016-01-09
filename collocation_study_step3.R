# 1. ��� ��+�� ���� �ڷ� �������� �����Ǻ� ��Ȯ���� ���� ���Է� �׸� �׸���

library(devtools)
source_url('https://raw.github.com/cognitivepsychology/cognitive_psychology/master/collocation_study_step2.R')
# �ҽ� ������ ���� �����ް� �ʹٸ� ������ ������ ��: download.file('https://raw.github.com/cognitivepsychology/cognitive_psychology/master/collocation_study_step2.R')

# �ڷ��� ���¸� �ٲ��ִ� ��Ű�� reshape2 �ҷ�����.
library(reshape2)

## (1) ��� ��+�� ���� �ڷ� �������� �����Ǻ� ��Ȯ�� �׸� �׸���

### 1) 5�� AM�� ���� n�뺰 �����Ǻ� ��Ȯ���� ���� ���Է��� ���� �ϳ��� ���� �����ϱ�

whole.human.pr.melt.prec <- melt(whole.human.prec.rec.nbest, measure.vars=c("prec.freq", "prec.MI", "prec.chisq", "prec.ttest", "prec.ll"))
# 5�� AM �̸��� ���յ� "variable" �� ������ "prec.AM"���� �ٲٱ�.
colnames(whole.human.pr.melt.prec)[8] <- c("prec.AM") 
# 5�� AM�� ��Ȯ���� ���յ� "value" �� ������ "prec"���� �ٲٱ�.
colnames(whole.human.pr.melt.prec)[9] <- c("prec") 
whole.human.pr.melt.rec <- melt(whole.human.prec.rec.nbest, measure.vars=c("rec.freq", "rec.MI", "rec.chisq", "rec.ttest", "rec.ll"))
# 5�� AM�� �̸��� ���յ� "variable" �� ������ "rec.AM"���� �ٲٱ�.
colnames(whole.human.pr.melt.rec)[8] <- c("rec.AM") 
# 5�� AM�� ��Ȯ���� ���յ� "value" �� ������ "rec"���� �ٲٱ�.
colnames(whole.human.pr.melt.rec)[9] <- c("rec") 
whole.human.pr.melt <- data.frame(cbind(whole.human.pr.melt.prec[, 6:9], whole.human.pr.melt.rec[, 8:9]))

### 2) �ѱ� ��ü ���� �� �ѱ� ���� ������ ���� R ȯ�� �����ϱ�

# ggplot2 ��Ű�� �ҷ�����.
library(ggplot2) 
# �������� ��Ʈ�� R ��Ʈ �ý��ۿ� ������Ű��. 
windowsFonts(NanumGothic = windowsFont("���� ����")) 
# R���� �ѱ� �Է� �� ������ ���� �����ϱ�.
Sys.setlocale("LC_COLLATE", "ko_KR.UTF-8") 

### 3) ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� �׸��� ���� ggplot2 �ڵ� �ۼ��ϱ�

# ��� ��+�� ���� �� ��¥ ������ ���� ����ϱ�. ���: 0.4034188.
TPall <- sum(whole.one.am.human$human) * 100 / nrow(whole.one.am.human) 
p.prec.per <- ggplot(data=whole.human.pr.melt, aes(x=n.percent, y=prec, linetype=prec.AM, color=prec.AM)) + geom_line(size=0.5)
p.prec.per <- p.prec.per + scale_colour_brewer(palette="Set1", name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.prec.per <- p.prec.per + scale_linetype_manual(values = c("solid", "dashed", "dotted", "dotdash", "longdash"), name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.prec.per <- p.prec.per + scale_x_continuous(limits=c(0,100), breaks=c(0,10,20,30,40,50,60,70,80,90,100)) 
p.prec.per <- p.prec.per + scale_y_continuous(limits=c(0,100), breaks=c(0,10,20,30,40,50,60,70,80,90,100)) 
# ���� 10% ��+�� ���� ��� ���� ǥ��.
p.prec.per <- p.prec.per + geom_hline(aes(yintercept=TPall), size=0.5) + geom_vline(aes(xintercept=10), linetype="dashed", size=0.5)
p.prec.per <- p.prec.per + labs(x="���� n% ��+�� ���� ���", y="�����Ǻ� ��Ȯ��(%)")
p.prec.per <- p.prec.per + theme(title=element_text(family = "NanumGothic", color="black"),
                                 axis.title=element_text(size=13),
                                 legend.title=element_text(size=10), 
                                 legend.text=element_text(size=10),
                                 legend.position = c(.83, .8),
                                 axis.text=element_text(size=10),
                                 legend.background=element_rect(colour = "black"),
                                 legend.key=element_rect(colour="black"),
                                 legend.direction="vertical",
                                 legend.position="right")

### 4) ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� �׸� �����ϱ�

# png ���Ϸ� �����ϱ�.
png(width = 1100, height = 1100, filename = "p.prec.per.png", type = "cairo", 
    antialias = "subpixel", family = "NanumGothic", res = 220)
p.prec.per 
dev.off()
# pdf ���Ϸ� �����ϱ�.
cairo_pdf(filename = "p.prec.per.pdf", family="NanumGothic", width=7, height=7, antialias = "subpixel")
p.prec.per  
dev.off()

## (2) ��� ��+�� ���� �ڷ� �������� ���� ���Է� �׸� �׸���

### 1) ���� n�ۼ�Ʈ ���� ���Է� �׸��� ���� ggplot2 �ڵ� �ۼ��ϱ�

p.rec.per <- ggplot(data=whole.human.pr.melt, aes(x=n.percent, y=rec, linetype=rec.AM, color=rec.AM)) + geom_line(size=0.5)
p.rec.per <- p.rec.per + scale_colour_brewer(palette="Set1", name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.rec.per <- p.rec.per + scale_linetype_manual(values = c("solid", "dashed", "dotted", "dotdash", "longdash"), name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.rec.per <- p.rec.per + scale_x_continuous(limits=c(0,100), breaks=c(0,10,20,30,40,50,60,70,80,90,100)) 
p.rec.per <- p.rec.per + scale_y_continuous(limits=c(0,100), breaks=c(0,10,20,30,40,50,60,70,80,90,100)) 
p.rec.per <- p.rec.per + labs(x="���� n% ��+�� ���� ���", y="���� ���Է�(%)")
p.rec.per <- p.rec.per + theme(title=element_text(family = "NanumGothic", color="black"),
                               axis.title=element_text(size=13),
                               legend.title=element_text(size=10), 
                               legend.text=element_text(size=10),
                               legend.position = c(.17, .8),
                               axis.text=element_text(size=10),
                               legend.background=element_rect(colour = "black"),
                               legend.key=element_rect(colour="black"),
                               legend.direction="vertical",
                               legend.position="right")


### 2) ���� n�ۼ�Ʈ ���� ���Է� �׸� �����ϱ�

# png ���Ϸ� �����ϱ�.
png(width = 1100, height = 1100, filename = "p.rec.per.png", type = "cairo", 
    antialias = "subpixel", family = "NanumGothic", res = 220)
p.rec.per  
dev.off()
# pdf ���Ϸ� �����ϱ�.
cairo_pdf(filename = "p.rec.per.pdf", family="NanumGothic", width=7, height=7, antialias = "subpixel")
p.rec.per  
dev.off()

# 2. ��(ު)�ϴٷ� ���� �ڷ� �������� �����Ǻ� ��Ȯ���� ���� ���Է� �׸� �׸���

## (1) ��� ��(ު)�ϴٷ� ���� �ڷ� �������� �����Ǻ� ��Ȯ�� �׸� �׸���

### 1) 5�� AM�� ���� n�뺰 �����Ǻ� ��Ȯ���� ���� ���Է��� ���� �ϳ��� ���� �����ϱ�

whole.human.pr.melt.prec.no.ha <- melt(whole.human.prec.rec.nbest.no.ha, measure.vars=c("prec.freq.no.ha", "prec.MI.no.ha", "prec.chisq.no.ha", "prec.ttest.no.ha", "prec.ll.no.ha"))
# 5�� AM �̸��� ���յ� "variable" �� ������ "prec.AM"���� �ٲٱ�.
colnames(whole.human.pr.melt.prec.no.ha)[8] <- c("prec.AM")
# 5�� AM�� ��Ȯ���� ���յ� "value" �� ������ "prec"���� �ٲٱ�.
colnames(whole.human.pr.melt.prec.no.ha)[9] <- c("prec")
whole.human.pr.melt.rec.no.ha <- melt(whole.human.prec.rec.nbest.no.ha, measure.vars=c("rec.freq.no.ha", "rec.MI.no.ha", "rec.chisq.no.ha", "rec.ttest.no.ha", "rec.ll.no.ha"))
# 5�� AM�� �̸��� ���յ� "variable" �� ������ "rec.AM"���� �ٲٱ�.
colnames(whole.human.pr.melt.rec.no.ha)[8] <- c("rec.AM")
# 5�� AM�� ��Ȯ���� ���յ� "value" �� ������ "rec"���� �ٲٱ�.
colnames(whole.human.pr.melt.rec.no.ha)[9] <- c("rec")
whole.human.pr.melt.no.ha <- data.frame(cbind(whole.human.pr.melt.prec.no.ha[, 6:9], whole.human.pr.melt.rec.no.ha[, 8:9]))

### 2) ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� �׸��� ���� ggplot2 �ڵ� �ۼ��ϱ�

# ��(ު)�ϴٷ� ���� �� ��¥ ������ ���� ����ϱ�. ���: 0.2307692.
TP.no.ha <- sum(whole.one.no.ha$human) * 100 / nrow(whole.one.no.ha) 
p.prec.nh.per <- ggplot(data=whole.human.pr.melt.no.ha, aes(x=n.percent.no.ha, y=prec, linetype=prec.AM, color=prec.AM)) + geom_line(size=0.5)
p.prec.nh.per <- p.prec.nh.per + scale_colour_brewer(palette="Set1", name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.prec.nh.per <- p.prec.nh.per + scale_linetype_manual(values = c("solid", "dashed", "dotted", "dotdash", "longdash"), name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.prec.nh.per <- p.prec.nh.per + scale_x_continuous(limits=c(0,100), breaks=c(0,10,20,30,40,50,60,70,80,90,100)) 
p.prec.nh.per <- p.prec.nh.per + scale_y_continuous(limits=c(0,100), breaks=c(0,10,20,30,40,50,60,70,80,90,100)) 
# ���� 10% ��+�� ���� ��� ���� ǥ���ϱ�.
p.prec.nh.per <- p.prec.nh.per + geom_hline(aes(yintercept=TP.no.ha), size=0.5) + geom_vline(aes(xintercept=10), linetype="dashed", size=0.5)
p.prec.nh.per <- p.prec.nh.per + labs(x="���� n% ��+�� ���� ���", y="�����Ǻ� ��Ȯ��(%)")
p.prec.nh.per <- p.prec.nh.per + theme(title=element_text(family = "NanumGothic", color="black"),
                                       axis.title=element_text(size=13),
                                       legend.title=element_text(size=10), 
                                       legend.text=element_text(size=10),
                                       legend.position = c(.83, .8),
                                       axis.text=element_text(size=10),
                                       legend.background=element_rect(colour = "black"),
                                       legend.key=element_rect(colour="black"),
                                       legend.direction="vertical",
                                       legend.position="right")


### 3) ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� �׸� �����ϱ�

# png ���Ϸ� �����ϱ�.
png(width = 1100, height = 1100, filename = "p.prec.nh.per.png", type = "cairo", 
    antialias = "subpixel", family = "NanumGothic", res = 220)
p.prec.nh.per
dev.off()
# pdf ���Ϸ� �����ϱ�.
cairo_pdf(filename = "p.prec.nh.per.pdf", family="NanumGothic", width=7, height=7, antialias = "subpixel")
p.prec.nh.per
dev.off()

## (2) ���� 500�� ��(ު)�ϴٷ� ���� �ڷ� �������� �����Ǻ� ��Ȯ�� �׸� �׸���

### 1) ���� n�� �����Ǻ� ��Ȯ�� �׸��� ���� ggplot2 �ڵ� �ۼ��ϱ�

# ��(ު)�ϴٷ� ���� �� ��¥ ������ ���� ����ϱ�. ���: 0.2307692.
TP.no.ha <- sum(whole.one.no.ha$human) * 100 / nrow(whole.one.no.ha) 
p.prec.nh.500 <- ggplot(data=whole.human.pr.melt.no.ha, aes(x=n.best.no.ha, y=prec, linetype=prec.AM, color=prec.AM)) + geom_line(size=0.5)
p.prec.nh.500 <- p.prec.nh.500 + scale_colour_brewer(palette="Set1", name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.prec.nh.500 <- p.prec.nh.500 + scale_linetype_manual(values = c("solid", "dashed", "dotted", "dotdash", "longdash"), name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.prec.nh.500 <- p.prec.nh.500 + scale_x_continuous(limits=c(0,500), breaks=c(0,50,100,150,200,250,300,350,400,450,500)) 
p.prec.nh.500 <- p.prec.nh.500 + scale_y_continuous(limits=c(0,100), breaks=c(0,10,20,30,40,50,60,70,80,90,100)) 
# ���� 10% ��+�� ���� ��� ���� ǥ���ϱ�. 
ten.point <- nrow(whole.one.no.ha) / 10
p.prec.nh.500 <- p.prec.nh.500 + geom_hline(aes(yintercept=TP.no.ha), size=0.5) + geom_vline(aes(xintercept=ten.point), linetype="dashed", size=0.5)
p.prec.nh.500 <- p.prec.nh.500 + labs(x="���� n�� ��+�� ���� ���", y="�����Ǻ� ��Ȯ��(%)")
p.prec.nh.500 <- p.prec.nh.500 + theme(title=element_text(family = "NanumGothic", color="black"),
                                       axis.title=element_text(size=13),
                                       legend.title=element_text(size=10), 
                                       legend.text=element_text(size=10),
                                       legend.position = c(.83, .8),
                                       axis.text=element_text(size=10),
                                       legend.background=element_rect(colour = "black"),
                                       legend.key=element_rect(colour="black"),
                                       legend.direction="vertical",
                                       legend.position="right")


### 2) ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� �׸� �����ϱ�

# png ���Ϸ� �����ϱ�.
png(width = 1100, height = 1100, filename = "p.prec.nh.500.png", type = "cairo", 
    antialias = "subpixel", family = "NanumGothic", res = 220)
p.prec.nh.500
dev.off()
# pdf ���Ϸ� �����ϱ�.
cairo_pdf(filename = "p.prec.nh.500.pdf", family="NanumGothic", width=7, height=7, antialias = "subpixel")
p.prec.nh.500
dev.off()

## (3) ��� ��(ު)�ϴٷ� ���� �ڷ� �������� ���� ���Է� �׸� �׸���

### 1) ���� n�ۼ�Ʈ ���� ���Է� �׸��� ���� ggplot2 �ڵ� �ۼ��ϱ�


p.rec.nh.per <- ggplot(data=whole.human.pr.melt.no.ha, aes(x=n.percent.no.ha, y=rec, linetype=rec.AM, color=rec.AM)) + geom_line(size=0.5)
p.rec.nh.per <- p.rec.nh.per + scale_colour_brewer(palette="Set1", name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.rec.nh.per <- p.rec.nh.per + scale_linetype_manual(values = c("solid", "dashed", "dotted", "dotdash", "longdash"), name="�������",labels=c("�����", "��ȣ����", "ī������ ����", "t-����", "�α� �쵵��"))
p.rec.nh.per <- p.rec.nh.per + scale_x_continuous(limits=c(0,100), breaks=c(0,10,20,30,40,50,60,70,80,90,100)) 
p.rec.nh.per <- p.rec.nh.per + scale_y_continuous(limits=c(0,100), breaks=c(0,10,20,30,40,50,60,70,80,90,100)) 
p.rec.nh.per <- p.rec.nh.per + labs(x="���� n% ��+�� ���� ���", y="���� ���Է�(%)")
p.rec.nh.per <- p.rec.nh.per + theme(title=element_text(family = "NanumGothic", color="black"),
                                     axis.title=element_text(size=13),
                                     legend.title=element_text(size=10), 
                                     legend.text=element_text(size=10),
                                     legend.position = c(.17, .8),
                                     axis.text=element_text(size=10),
                                     legend.background=element_rect(colour = "black"),
                                     legend.key=element_rect(colour="black"),
                                     legend.direction="vertical",
                                     legend.position="right")


### 2) ���� n�ۼ�Ʈ ���� ���Է� �׸� �����ϱ�

# png ���Ϸ� �����ϱ�.
png(width = 1100, height = 1100, filename = "p.rec.nh.per.png", type = "cairo", 
    antialias = "subpixel", family = "NanumGothic", res = 220)
p.rec.nh.per  
dev.off()
# pdf ���Ϸ� �����ϱ�.
cairo_pdf(filename = "p.rec.nh.per.pdf", family="NanumGothic", width=7, height=7, antialias = "subpixel")
p.rec.nh.per
dev.off()