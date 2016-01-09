# 1. �����Ǻ� ��Ȯ���� ���� ���Է� �Ұ�

# 2. �����ڷ� �Ұ� 

# 3. �����Ǻ� ��Ȯ�� ��� �� ǥ �ۼ��ϱ�

## (1) ��� ��+�� ���� ������� �����Ǻ� ��Ȯ�� ��� �� ǥ �ۼ��ϱ�

### 1) 5�� AM�� ���� n�� �����Ǻ� ��Ȯ�� ��� �� ǥ �ۼ��ϱ� 

library(devtools)
source_url('https://raw.github.com/cognitivepsychology/cognitive_psychology/master/collocation_study_step1.R')

# �ҽ� ������ ���� �����ް� �ʹٸ� ������ ������ ��: download.file('https://raw.github.com/cognitivepsychology/cognitive_psychology/master/collocation_study_step1.R'

show.prec <- function(mydata, AM, n.best) {
  stopifnot(AM %in% colnames(mydata)) # ���� AM�� �� �������� ���� �ڷḸ ��� ����� ��!
  sort.idx <- order(mydata[[AM]], decreasing=TRUE)
  prec <- cumsum(mydata$human[sort.idx]) / (1:nrow(mydata))
  result <- data.frame(100 * prec[n.best]) # ��Ȯ���� �ۼ�Ʈ�� ��Ÿ����.
  result <- round(result, 2) # ��Ȯ���� �Ҽ��� ���� ��° �ڸ������� ������.
  rownames(result) <- n.best # �� ������ n.best��.
  colnames(result) <- AM # �� ������ ���� AM�� �̸�����.
  result # ���� n���� ��+�� ���⿡ ���� Ư�� AM�� �����Ǻ� ��Ȯ���� ��������.
}

show.prec(whole.one.am.human, "chisq", c(50,100,200,500,1000,2000))
show.prec(whole.one.am.human, "o11", c(50,100,200,500,1000,2000))
show.prec(whole.one.am.human, "logl", c(50,100,200,500,1000,2000))
show.prec(whole.one.am.human, "ttest", c(50,100,200,500,1000,2000))
show.prec(whole.one.am.human, "MI", c(50,100,200,500,1000,2000))

### 2) 5�� AM�� ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� ��� �� ǥ �ۼ��ϱ�

# AM�� ���� n % �����Ǻ� ��Ȯ�� ǥ �����.
show.prec.percent <- function(mydata, AM, n.percent) {
  stopifnot(AM %in% colnames(mydata)) # ���� AM�� �� �������� ���� �ڷḸ ��� ����� ��!
  sort.idx <- order(mydata[[AM]], decreasing=TRUE)
  prec <- cumsum(mydata$human[sort.idx]) / (1:nrow(mydata))
  result <- data.frame(100 * prec[nrow(mydata)*n.percent/100]) # ��Ȯ���� �ۼ�Ʈ�� ��Ÿ����. 
  result <- round(result, 2)
  rownames(result) <- n.percent # �� ������ n.percent��.
  colnames(result) <- AM # �� ������ ���� AM�� �̸�����.
  result # ���� n% ��+�� ���⿡ ���� Ư�� AM�� �����Ǻ� ��Ȯ���� ��������.
}

show.prec.percent(whole.one.am.human, "chisq", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) 
show.prec.percent(whole.one.am.human, "o11", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) 
show.prec.percent(whole.one.am.human, "logl", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) 
show.prec.percent(whole.one.am.human, "ttest", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) 
show.prec.percent(whole.one.am.human, "MI", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) 

### 3) 5�� AM ���� ���� n�� �����Ǻ� ��Ȯ�� ǥ �ۼ��ϱ�

# ���� n�� ��+�� ���⿡ ���� 5�� AM�� �����Ǻ� ��Ȯ���� �ϳ��� ǥ�� ��Ÿ����.

n.list <- c(50,100,200,500,1000,1500,2000,2340)
prec.list <- lapply(
  c("o11", "MI", "chisq", "ttest", "logl"),
  function (AM) show.prec(whole.one.am.human, AM, n.list)
)
prec.table <- do.call(cbind, prec.list)

### 4) 5�� AM ���� ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� ǥ �ۼ��ϱ�

# ���� n�ۼ�Ʈ ��+�� ���⿡ ���� 5�� AM�� �����Ǻ� ��Ȯ���� �ϳ��� ǥ�� ��Ÿ����.

p.list <- c(1,5,10,20,30,40,50,60,70,80,90,100)
prec.percent.list <- lapply(
  c("o11", "MI", "chisq", "ttest", "logl"),
  function (AM) show.prec.percent(whole.one.am.human, AM, p.list)
)
prec.percent.table <- do.call(cbind, prec.percent.list)

### 5) 5�� AM ���� ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� ǥ�� ��� �����Ǻ� ��Ȯ�� �߰��ϱ�

#### A. 5�� AM�� �����Ǻ� ��Ȯ���� �ϳ��� ���������������� �����ϱ�

##### ��. 5�� AM ����ġ�� ������������ �����ϱ�

idx.logl <- order(whole.one.am.human$logl, decreasing=TRUE)
idx.chisq <- order(whole.one.am.human$chisq, decreasing=TRUE)
idx.ttest <- order(whole.one.am.human$ttest, decreasing=TRUE)
idx.mi <- order(whole.one.am.human$MI, decreasing=TRUE)
idx.freq <- order(whole.one.am.human$o11, decreasing=TRUE)

##### ��. 5�� AM�� �����Ǻ� ��Ȯ�� ����ϱ�

n.vals <- 1:nrow(whole.one.am.human)
prec.ll <- round(cumsum(whole.one.am.human$human[idx.logl]) * 100 / n.vals, 2)
prec.chisq <- round(cumsum(whole.one.am.human$human[idx.chisq]) * 100 / n.vals, 2)
prec.ttest <- round(cumsum(whole.one.am.human$human[idx.ttest]) * 100 / n.vals, 2)
prec.MI <- round(cumsum(whole.one.am.human$human[idx.mi]) * 100 / n.vals, 2)
prec.freq <- round(cumsum(whole.one.am.human$human[idx.freq]) * 100 / n.vals, 2)

##### ��. ���� 5�� AM�� ��Ȯ�� ���͸� �ϳ��� ���������������� �����ϱ�

whole.human.prec <- cbind(prec.ll, prec.chisq, prec.ttest, prec.MI, prec.freq)
whole.human.prec <- data.frame(whole.human.prec)

#### B. 5�� AM�� ���Է��� ��Ȯ�� �����������ӿ� �߰��ϱ�

##### ��. 5�� AM ����ġ�� ������������ �����ϱ�

idx.logl <- order(whole.one.am.human$logl, decreasing=TRUE)
idx.chisq <- order(whole.one.am.human$chisq, decreasing=TRUE)
idx.ttest <- order(whole.one.am.human$ttest, decreasing=TRUE)
idx.mi <- order(whole.one.am.human$MI, decreasing=TRUE)
idx.freq <- order(whole.one.am.human$o11, decreasing=TRUE)

##### ��. 5�� AM�� ���� ���Է� ����ϱ�

rec.ll <- round(cumsum(whole.one.am.human$human[idx.logl]) * 100 / sum(whole.one.am.human$human), 2)
rec.chisq <- round(cumsum(whole.one.am.human$human[idx.chisq]) * 100 / sum(whole.one.am.human$human), 2)
rec.ttest <- round(cumsum(whole.one.am.human$human[idx.ttest]) * 100 / sum(whole.one.am.human$human), 2)
rec.MI <- round(cumsum(whole.one.am.human$human[idx.mi]) * 100 / sum(whole.one.am.human$human), 2)
rec.freq <- round(cumsum(whole.one.am.human$human[idx.freq]) * 100 / sum(whole.one.am.human$human), 2)
whole.human.rec <- cbind(rec.ll, rec.chisq, rec.ttest, rec.MI, rec.freq)
whole.human.rec <- data.frame(whole.human.rec)
# ��Ȯ���� ���Է� �ڷ� ��ġ��.
whole.human.prec.rec <- cbind(whole.human.prec, whole.human.rec)
# ������ �ڷḦ ������������ �������� ��ȯ�ϱ�.
whole.human.prec.rec <- data.frame(whole.human.prec.rec)

##### ��. x���� ������ �ڷ� �� �����

n.best <- 1:nrow(whole.human.prec.rec)
whole.human.prec.rec.nbest <- transform(whole.human.prec.rec, n.best=n.best)

n.percent <- n.best * 100 / nrow(whole.human.prec.rec.nbest)
n.percent <- round(n.percent, 2)
whole.human.prec.rec.nbest <- transform(whole.human.prec.rec.nbest, n.percent=n.percent)

##### ��. 5�� AM�� ��� �����Ǻ� ��Ȯ�� �����ϱ�

# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� ������� ��� �����Ǻ� ��Ȯ��.
ave.prec.freq.5.95 <- mean(whole.human.prec.rec.nbest$prec.freq[whole.human.prec.rec.nbest$rec.freq >= 5 & whole.human.prec.rec.nbest$rec.freq <= 95]) 
# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� �α� �쵵���� ��� �����Ǻ� ��Ȯ��.
ave.prec.ll.5.95 <- mean(whole.human.prec.rec.nbest$prec.ll[whole.human.prec.rec.nbest$rec.ll >= 5 & whole.human.prec.rec.nbest$rec.ll <= 95]) 
# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� ī������ ������ ��� �����Ǻ� ��Ȯ��.
ave.prec.chisq.5.95 <- mean(whole.human.prec.rec.nbest$prec.chisq[whole.human.prec.rec.nbest$rec.chisq >= 5 & whole.human.prec.rec.nbest$rec.chisq <= 95]) 
# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� t-���� ��� �����Ǻ� ��Ȯ��.
ave.prec.ttest.5.95 <-  mean(whole.human.prec.rec.nbest$prec.ttest[whole.human.prec.rec.nbest$rec.ttest >= 5 & whole.human.prec.rec.nbest$rec.ttest <= 95])
# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� ��ȣ������ ��� �����Ǻ� ��Ȯ��.
ave.prec.MI.5.95 <- mean(whole.human.prec.rec.nbest$prec.MI[whole.human.prec.rec.nbest$rec.MI >= 5 & whole.human.prec.rec.nbest$rec.MI <= 95])

##### ��. 5�� AM ���� �����Ǻ� ��Ȯ�� ǥ�� ��� �����Ǻ� ��Ȯ�� �� �߰��ϱ�

# 5�� AM�� ��� �����Ǻ� ��Ȯ�� ���� ���� ���� �����.
ave.AM.vector <- c(ave.prec.freq.5.95, ave.prec.MI.5.95, ave.prec.chisq.5.95, ave.prec.ttest.5.95, ave.prec.ll.5.95)
# �Ҽ��� �� �ڸ������� ǥ���.
ave.AM.vector <- round(ave.AM.vector, 2)
# 5�� AM�� ��� �����Ǻ� ��Ȯ�� �� ���͸� 5�� AM ���� �����Ǻ� ��Ȯ�� ǥ ������ ������ �߰��ϱ�.
prec.percent.table <- rbind(prec.percent.table, ave.AM.vector)
prec.table <- rbind(prec.table, ave.AM.vector)
# ��� �����Ǻ� ��Ȯ�� �� ������ "���"���� �����ϱ�.
rownames(prec.percent.table) <- c(p.list, "average") 
rownames(prec.table) <- c(n.list, "average") 

### 6) 5�� AM ���� �����Ǻ� ��Ȯ�� ǥ ������ ����ϱ�

# �������������� R �� html ������ ǥ�� ���·� ������ִ� ��Ű�� sjPlot �ҷ�����.
library(sjPlot)
# 5�� AM�� ���� n�뺰 �����Ǻ� ��Ȯ�� ǥ(������) �ۼ��ϱ�. �̶� "title =" ������ ���� ǥ ���� R�󿡼� �߰��� �� ������, �ѱ� �Է� �� ���� ���� �߻�. ǥ ������ �����󿡼� �߰��� ��.
sjt.df(prec.table, describe = F) 
# 5�� AM�� ���� n%�� �����Ǻ� ��Ȯ�� ǥ(������) �ۼ��ϱ�.
sjt.df(prec.percent.table, describe = F)

### 7) ���� 1600�� �̻� ��+�� ���� ��� �ļӺм�

#### A. AM�� ���� 1600�� �̻� ��+�� ���� �����ϱ�

##### ��. ��ȣ���� ���� 1600�� �̻� ��+�� ���� �����ϱ� 

# ��ȣ������ ������������ �����ϱ�.
idx.MI <- order(whole.one.am.human$MI, decreasing=TRUE) 
# ��ȣ������ �������� ������������ �������� �����ϱ�.
whole.one.am.human.MI <- whole.one.am.human[idx.MI, ] 
# ��ȣ���� ���� 1600-2340�� ���� ��� �����ϱ�.
inspect.mi <- whole.one.am.human.MI[1600:2340, ]
# ��ȣ���� ���� 1600-2340�� ���� ����� csv �������� �����ϱ�. csv ������ �������� ��� �� ����. �ش� ����� ������ �ҷ��� ���캼 ���, �ξ� �������� ���� �� ����.
write.csv(inspect.mi, file="inspect.mi.csv") 
inspect.mi[, c(1:6, 24)]

##### ��. ī������ ���� ���� 1600�� �̻� ��+�� ���� �����ϱ� 

# ī������ ���� ������������ �����ϱ�.
idx.chisq <- order(whole.one.am.human$chisq, decreasing=TRUE) 
# ī������ ���� �������� ������������ �������� �����ϱ�.
whole.one.am.human.chisq <- whole.one.am.human[idx.chisq, ]
# ī������ �� ���� 1600-2340�� ��+�� ���� ��� �����ϱ�. 
inspect.chisq <- whole.one.am.human.chisq[1600:2340, ]
# ī������ �� ���� 1600-2340�� ��+�� ���� ��� csv �������� �����ϱ�.
write.csv(inspect.chisq, file="inspect.chisq.csv") 
inspect.chisq[, c(1:6, 24)]

##### ��. *t*-���� ���� 1600�� �̻� ��+�� ���� �����ϱ� 

# t-���� ������������ �����ϱ�.
idx.ttest <- order(whole.one.am.human$ttest, decreasing=TRUE)
# t-���� �������� ������������ �������� �����ϱ�.
whole.one.am.human.ttest <- whole.one.am.human[idx.ttest, ]
# t-�� ���� 1600-2340�� ��+�� ���� ��� �����ϱ�.
inspect.ttest <- whole.one.am.human.ttest[1600:2340, ]
# t-�� ���� 1600-2340�� ��+�� ���� ��� csv �������� �����ϱ�.
write.csv(inspect.ttest, file="inspect.ttest.csv")
inspect.ttest[, c(1:6, 24)]

##### ��. �α� �쵵�� ���� 1600�� �̻� ��+�� ���� �����ϱ� 

# �α� �쵵�� ������������ �����ϱ�.
idx.logl <- order(whole.one.am.human$logl, decreasing=TRUE)
# �α� �쵵�� �������� ������������ �������� �����ϱ�.
whole.one.am.human.logl <- whole.one.am.human[idx.logl, ] 
# �α� �쵵�� ���� 1600-2340�� ��+�� ���� ��� �����ϱ�.
inspect.logl <- whole.one.am.human.logl[1600:2340, ]
# �α� �쵵�� ���� 1600-2340�� ��+�� ���� ��� csv �������� �����ϱ�.
write.csv(inspect.logl, file="inspect.logl.csv")
inspect.logl[, c(1:6, 24)]

##### ��. ����� ���� 1600�� �̻� ��+�� ���� �����ϱ� 

# ����󵵸� ������������ �����ϱ�.
idx.o11 <- order(whole.one.am.human$o11, decreasing=TRUE) 
# ����󵵸� �������� ������������ �������� �����ϱ�.
whole.one.am.human.o11 <- whole.one.am.human[idx.o11, ] 
# ����� ���� 1600-2340�� ��+�� ���� ��� �����ϱ�.
inspect.o11 <- whole.one.am.human.o11[1600:2340, ]
# ����� ���� 1600-2340�� ��+�� ���� ��� csv �������� �����ϱ�.
write.csv(inspect.o11, file="inspect.o11.csv") 
inspect.o11[, c(1:6, 24)]

#### B. ���� 1600�� �̻� ��+�� ���� ��Ͽ� ���� AM�� ��� �����Ǻ� ��Ȯ�� ����ϱ�

sum(inspect.mi$human)/nrow(inspect.mi) # ��Ȯ��: 0.7516869.
sum(inspect.chisq$human)/nrow(inspect.chisq) # ��Ȯ��: 0.6356275.
sum(inspect.ttest$human)/nrow(inspect.ttest) # ��Ȯ��: 0.5641026.
sum(inspect.logl$human)/nrow(inspect.logl) # ��Ȯ��: 0.5492578.
sum(inspect.o11$human)/nrow(inspect.o11) # ��Ȯ��: 0.294197.

length(grep("NNG��JKO[ \t\n]��VV", inspect.mi$bigram, value=T)) / nrow(inspect.mi) # 611/741 =  0.8245614
length(grep("NNG��JKO[ \t\n]��VV", inspect.chisq$bigram, value=T)) / nrow(inspect.chisq) # 504/741 = 0.6801619
length(grep("NNG��JKO[ \t\n]��VV", inspect.ttest$bigram, value=T)) / nrow(inspect.ttest) # 450/741 = 0.6072874
length(grep("NNG��JKO[ \t\n]��VV", inspect.logl$bigram, value=T)) / nrow(inspect.logl) # 424/741 = 0.5721997
length(grep("NNG��JKO[ \t\n]��VV", inspect.o11$bigram, value=T)) / nrow(inspect.o11) # 137/741 = 0.1848853

## (2) ��(ު)�ϴٷ� ���� ������� �����Ǻ� ��Ȯ�� ��� �� ǥ �ۼ��ϱ�

### 1) ��ü ��+�� ���� ��Ͽ��� �ϴٷ� ���� �����ϱ�

whole.one.no.ha <- whole.one.am.human[-grep("NNG��JKO[ \t\n]��VV", whole.one.am.human$bigram), ]
nrow(whole.one.no.ha) # ��(ު)�ϴٷ� ������ ��(N = 1729) Ȯ���ϱ�.

### 2) 5�� AM�� ���� n�� �����Ǻ� ��Ȯ�� ��� �� ǥ �ۼ��ϱ� 

show.prec(whole.one.no.ha, "chisq", c(50,100,200,500,1000,1500,1729))
show.prec(whole.one.no.ha, "o11", c(50,100,200,500,1000,1500,1729))
show.prec(whole.one.no.ha, "logl", c(50,100,200,500,1000,1500,1729))
show.prec(whole.one.no.ha, "ttest", c(50,100,200,500,1000,1500,1729))
show.prec(whole.one.no.ha, "MI", c(50,100,200,500,1000,1500,1729))

### 3) 5�� AM�� ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� ��� �� ǥ �ۼ��ϱ� 

show.prec.percent(whole.one.no.ha, "chisq", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) 
show.prec.percent(whole.one.no.ha, "o11", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) 
show.prec.percent(whole.one.no.ha, "logl", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) 
show.prec.percent(whole.one.no.ha, "ttest", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)) 
show.prec.percent(whole.one.no.ha, "MI", c(1, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100))

### 4) 5�� AM ���� ���� n�� �����Ǻ� ��Ȯ�� ǥ �ۼ��ϱ�

n.no.ha.list <- c(50,100,200,500,1000,1500,1729)
prec.no.ha.list <- lapply(
  c("o11", "MI", "chisq", "ttest", "logl"),
  function (AM) show.prec(whole.one.no.ha, AM, n.no.ha.list)
)
prec.no.ha.table <- do.call(cbind, prec.no.ha.list)

### 5) 5�� AM ���� ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� ǥ �ۼ��ϱ�

p.list <- c(1,5,10,20,30,40,50,60,70,80,90,100)
prec.percent.no.ha.list <- lapply(
  c("o11", "MI", "chisq", "ttest", "logl"),
  function (AM) show.prec.percent(whole.one.no.ha, AM, p.list)
)
prec.percent.no.ha.table <- do.call(cbind, prec.percent.no.ha.list)

### 6) 5�� AM ���� ���� n�ۼ�Ʈ �����Ǻ� ��Ȯ�� ǥ�� ��� �����Ǻ� ��Ȯ�� �߰��ϱ�

#### A. 5�� AM�� �����Ǻ� ��Ȯ���� �ϳ��� ���������������� �����ϱ�

##### ��. 5�� AM ����ġ�� ������������ �����ϱ�

idx.logl.no.ha <- order(whole.one.no.ha$logl, decreasing=TRUE)
idx.chisq.no.ha <- order(whole.one.no.ha$chisq, decreasing=TRUE)
idx.ttest.no.ha <- order(whole.one.no.ha$ttest, decreasing=TRUE)
idx.mi.no.ha <- order(whole.one.no.ha$MI, decreasing=TRUE)
idx.freq.no.ha <- order(whole.one.no.ha$o11, decreasing=TRUE)

##### ��. 5�� AM�� �����Ǻ� ��Ȯ�� ����ϱ�

n.vals.no.ha <- 1:nrow(whole.one.no.ha)
prec.ll.no.ha <- round(cumsum(whole.one.no.ha$human[idx.logl.no.ha]) * 100 / n.vals.no.ha, 2)
prec.chisq.no.ha <- round(cumsum(whole.one.no.ha$human[idx.chisq.no.ha]) * 100 / n.vals.no.ha, 2)
prec.ttest.no.ha <- round(cumsum(whole.one.no.ha$human[idx.ttest.no.ha]) * 100 / n.vals.no.ha, 2)
prec.MI.no.ha <- round(cumsum(whole.one.no.ha$human[idx.mi.no.ha]) * 100 / n.vals.no.ha, 2)
prec.freq.no.ha <- round(cumsum(whole.one.no.ha$human[idx.freq.no.ha]) * 100 / n.vals.no.ha, 2)

##### ��. ���� 5�� AM�� ��Ȯ�� ���͸� �ϳ��� ���������������� �����ϱ�

whole.human.prec.no.ha <- cbind(prec.ll.no.ha, prec.chisq.no.ha, prec.ttest.no.ha, prec.MI.no.ha, prec.freq.no.ha)
whole.human.prec.no.ha <- data.frame(whole.human.prec.no.ha)

#### B. 5�� AM�� ���Է��� ��Ȯ�� �����������ӿ� �߰��ϱ�

##### ��. 5�� AM ����ġ�� ������������ �����ϱ�

idx.logl.no.ha <- order(whole.one.no.ha$logl, decreasing=TRUE)
idx.chisq.no.ha <- order(whole.one.no.ha$chisq, decreasing=TRUE)
idx.ttest.no.ha <- order(whole.one.no.ha$ttest, decreasing=TRUE)
idx.mi.no.ha <- order(whole.one.no.ha$MI, decreasing=TRUE)
idx.freq.no.ha <- order(whole.one.no.ha$o11, decreasing=TRUE)

##### ��. 5�� AM�� ���� ���Է� ����ϱ�

rec.ll.no.ha <- round(cumsum(whole.one.no.ha$human[idx.logl.no.ha]) * 100 / sum(whole.one.no.ha$human), 2)
rec.chisq.no.ha <- round(cumsum(whole.one.no.ha$human[idx.chisq.no.ha]) * 100 / sum(whole.one.no.ha$human), 2)
rec.ttest.no.ha <- round(cumsum(whole.one.no.ha$human[idx.ttest.no.ha]) * 100 / sum(whole.one.no.ha$human), 2)
rec.MI.no.ha <- round(cumsum(whole.one.no.ha$human[idx.mi.no.ha]) * 100 / sum(whole.one.no.ha$human), 2)
rec.freq.no.ha <- round(cumsum(whole.one.no.ha$human[idx.freq.no.ha]) * 100 / sum(whole.one.no.ha$human), 2)
whole.human.rec.no.ha <- cbind(rec.ll.no.ha, rec.chisq.no.ha, rec.ttest.no.ha, rec.MI.no.ha, rec.freq.no.ha)
whole.human.rec.no.ha <- data.frame(whole.human.rec.no.ha)
whole.human.prec.rec.no.ha <- cbind(whole.human.prec.no.ha, whole.human.rec.no.ha) # ��Ȯ��, ���Է� �ڷ� ��ġ��.
whole.human.prec.rec.no.ha <- data.frame(whole.human.prec.rec.no.ha) # ������ �ڷḦ ������ ������ �������� ��ȯ�ϱ�.

##### ��. x���� ������ �ڷ� �� �����

n.best.no.ha <- 1:nrow(whole.human.prec.rec.no.ha)
whole.human.prec.rec.nbest.no.ha <- transform(whole.human.prec.rec.no.ha, n.best.no.ha=n.best.no.ha)
n.percent.no.ha <- n.best.no.ha * 100 / nrow(whole.human.prec.rec.nbest.no.ha)
n.percent.no.ha <- round(n.percent.no.ha, 2)
whole.human.prec.rec.nbest.no.ha <- transform(whole.human.prec.rec.nbest.no.ha, n.percent.no.ha=n.percent.no.ha)

##### ��. 5�� AM�� ��� �����Ǻ� ��Ȯ�� �����ϱ�

# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� ������� ��� �����Ǻ� ��Ȯ��.
ave.prec.freq.no.ha <- mean(whole.human.prec.rec.nbest.no.ha$prec.freq[whole.human.prec.rec.nbest.no.ha$rec.freq >= 5 & whole.human.prec.rec.nbest.no.ha$rec.freq <= 95]) 
# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� �α� �쵵���� ��� �����Ǻ� ��Ȯ��.
ave.prec.ll.no.ha <- mean(whole.human.prec.rec.nbest.no.ha$prec.ll[whole.human.prec.rec.nbest.no.ha$rec.ll >= 5 & whole.human.prec.rec.nbest.no.ha$rec.ll <= 95]) 
# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� ī������ ������ ��� �����Ǻ� ��Ȯ��.
ave.prec.chisq.no.ha <- mean(whole.human.prec.rec.nbest.no.ha$prec.chisq[whole.human.prec.rec.nbest.no.ha$rec.chisq >= 5 & whole.human.prec.rec.nbest.no.ha$rec.chisq <= 95]) 
# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� t-���� ��� �����Ǻ� ��Ȯ��.
ave.prec.ttest.no.ha <-  mean(whole.human.prec.rec.nbest.no.ha$prec.ttest[whole.human.prec.rec.nbest.no.ha$rec.ttest >= 5 & whole.human.prec.rec.nbest.no.ha$rec.ttest <= 95]) 
# ���� ���Է� 0.5-0.95�� ���� �ش��ϴ� ��ȣ������ ��� �����Ǻ� ��Ȯ��.
ave.prec.MI.no.ha <- mean(whole.human.prec.rec.nbest.no.ha$prec.MI[whole.human.prec.rec.nbest.no.ha$rec.MI >= 5 & whole.human.prec.rec.nbest.no.ha$rec.MI <= 95])

##### ��. 5�� AM ���� �����Ǻ� ��Ȯ�� ǥ�� ��� �����Ǻ� ��Ȯ�� �� �߰��ϱ�

# 5�� AM�� ��� �����Ǻ� ��Ȯ�� ���� ���� ���� �����.
# 5�� AM�� ��� �����Ǻ� ��Ȯ�� ���� ���� ���� �����.
ave.AM.no.ha.vector <- c(ave.prec.freq.no.ha, ave.prec.MI.no.ha, ave.prec.chisq.no.ha, ave.prec.ttest.no.ha, ave.prec.ll.no.ha) 
# �Ҽ��� �� �ڸ������� ǥ���.
ave.AM.no.ha.vector <- round(ave.AM.no.ha.vector, 2)
# 5�� AM�� ��� �����Ǻ� ��Ȯ�� �� ���͸� 5�� AM ���� �����Ǻ� ��Ȯ�� ǥ ������ ������ �߰��ϱ�.
prec.percent.no.ha.table <- rbind(prec.percent.no.ha.table, ave.AM.no.ha.vector) 
prec.no.ha.table <- rbind(prec.no.ha.table, ave.AM.no.ha.vector) 
# ��� �����Ǻ� ��Ȯ�� �� ������ "���"���� �����ϱ�.
rownames(prec.percent.no.ha.table) <- c(p.list, "average") 
rownames(prec.no.ha.table) <- c(n.no.ha.list, "average") 

### 7) 5�� AM ���� �����Ǻ� ��Ȯ�� ǥ ����ϱ�

# ��(ު)�ϴٷ� ���⿡ ���� ���� n�뺰 5�� AM �����Ǻ� ��Ȯ�� ǥ(������) ����ϱ�.
sjt.df(prec.no.ha.table, describe = F) 
# ��(ު)�ϴٷ� ���⿡ ���� ���� n%�� 5�� AM �����Ǻ� ��Ȯ�� ǥ(������) ����ϱ�.
sjt.df(prec.percent.no.ha.table, describe = F) 

# 4. ���� ���Է� ��� �� ǥ �ۼ��ϱ�

## (1) ��� ��+�� ���� ������� ���� ���Է� ��� �� ǥ �ۼ��ϱ�

### 1) 5�� AM�� ���� n�� ���� ���Է� ��� �� ǥ �ۼ��ϱ� 

show.recall <- function(mydata, AM, n.best) {
  stopifnot(AM %in% colnames(mydata)) # ���� AM�� �� �������� ���� �ڷḸ ��� ����� ��!
  sort.idx <- order(mydata[[AM]], decreasing=TRUE)
  recall <- cumsum(mydata$human[sort.idx]) / sum(mydata$human)
  result <- data.frame(100 * recall[n.best]) # ���Է��� �ۼ�Ʈ�� ��Ÿ����.
  result <- round(result, 2) # ���Է��� �Ҽ��� ���� ��° �ڸ������� ������.
  rownames(result) <- n.best # �� �̸��� n.best��.
  colnames(result) <- AM # �� �̸��� ���� AM�� �̸�����.
  result # ���� n���� ��+�� ���⿡ ���� Ư�� AM�� ���� ���Է��� ����� ��������.
}

### 2) 5�� AM�� ���� n�ۼ�Ʈ ���� ���Է� ��� �� ǥ �ۼ��ϱ�

show.recall(whole.one.am.human, "chisq", c(50,100,200,500,1000,1500,2000,2340))
show.recall.percent <- function(mydata, AM, n.percent) {
  stopifnot(AM %in% colnames(mydata)) # ���� AM�� �� �������� ���� �ڷḸ ��� ����� ��!
  sort.idx <- order(mydata[[AM]], decreasing=TRUE)
  recall <- cumsum(mydata$human[sort.idx]) / sum(mydata$human)
  result <- data.frame(100 * recall[nrow(mydata)*n.percent/100]) # ���Է��� �ۼ�Ʈ�� ��Ÿ����. 
  result <- round(result, 2)
  rownames(result) <- n.percent # �� �̸��� n.percent��.
  colnames(result) <- AM # �� �̸��� ���� AM����.
  result # n���� ��+�� ���⿡ ���� Ư�� AM�� ���� ���Է��� ����� ��������.
}

### 3) 5�� AM ���� ���� n�� ���� ���Է� ǥ �ۼ��ϱ�

n.list <- c(50,100,200,500,1000,1500,2000,2340)
recall.list <- lapply(
  c("o11", "MI", "chisq", "ttest", "logl"),
  function (AM) show.recall(whole.one.am.human, AM, n.list)
)
recall.table <- do.call(cbind, recall.list)

### 4) 5�� AM ���� ���� n�ۼ�Ʈ ���� ���Է� ǥ �ۼ��ϱ�

p.list <- c(1,5,10,20,30,40,50,60,70,80,90,100)
recall.percent.list <- lapply(
  c("o11", "MI", "chisq", "ttest", "logl"),
  function (AM) show.recall.percent(whole.one.am.human, AM, p.list)
)
recall.percent.table <- do.call(cbind, recall.percent.list)

### 6) 5�� AM ���� ���� ���Է� ǥ ����ϱ�

# ���� n�뺰 ��+�� ���⿡ ���� 5�� ��������� ���� ���Է� ǥ(������) ����ϱ�.
sjt.df(recall.table, describe = F) 
# ���� n%�� ��+�� ���⿡ ���� 5�� ��������� ���� ���Է� ǥ(������) ����ϱ�.
sjt.df(recall.percent.table, describe = F) 

## (2) ��(ު)�ϴٷ� ���� ������� ���� ���Է� ��� �� ǥ �ۼ��ϱ�

### 1) 5�� AM ���� ���� n�� ���� ���Է� ǥ �ۼ��ϱ� 

n.no.ha.list <- c(50,100,200,500,1000,1500,1729)
recall.no.ha.list <- lapply(
  c("o11", "MI", "chisq", "ttest", "logl"),
  function (AM) show.recall(whole.one.no.ha, AM, n.no.ha.list)
)
recall.no.ha.table <- do.call(cbind, recall.no.ha.list)

### 2) 5�� AM ���� ���� n�ۼ�Ʈ ���� ���Է� ǥ �ۼ��ϱ� 

p.list <- c(1,5,10,20,30,40,50,60,70,80,90,100)
recall.percent.no.ha.list <- lapply(
  c("o11", "MI", "chisq", "ttest", "logl"),
  function (AM) show.recall.percent(whole.one.no.ha, AM, p.list)
)
recall.percent.no.ha.table <- do.call(cbind, recall.percent.no.ha.list)

### 3) 5�� AM ���� ���� ���Է� ǥ ����ϱ�

# ��(ު)�ϴٷ� ���⿡ ���� ���� n�뺰 5�� AM �����Ǻ� ��Ȯ�� ǥ(������) ����ϱ�.
sjt.df(recall.no.ha.table, describe = F)
# ��(ު)�ϴٷ� ���⿡ ���� ���� n%�� 5�� AM�� �����Ǻ� ��Ȯ�� ǥ(������) ����ϱ�.
sjt.df(recall.percent.no.ha.table, describe = F)