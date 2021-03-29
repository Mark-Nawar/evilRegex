
testspace<-c(
porto<-'Eu amo o Egito',
portoP<- 'Egito',
hindi<-'मुझे मिस्र से प्यार है',
hindiP<-'मिस्र',
Russian<-'Я люблю египет',
RussianP<-'египет',
swed<-'Jag älskar Egypten',
swedP<-'Egypten',
turkish<-'Mısır\'ı seviyorum',
turkishP<-'Misir',
german<-'Ich liebe Ägypten',
germanP<-'Ägypten',
greek<-'Λατρεύω την Αίγυπτο',
greekP<-'Αίγυπτο',
arabic<-'انا احب مصر',
arabicP<-'مصر' )


results_to_be_checked<-c(
    10,5,
    6,5,
    9,6,
    12,7,
    1,5,
    11,7,
    13,7,
    9,3
)
results_to_be_checked_ICU<-c(
    "Egito","",
    "<U+092E><U+093F><U+0938><U+094D><U+0930>","",
    "<U+0435><U+0433><U+0438><U+043F><U+0435><U+0442>","",
    "Egypten","",
    "Misir","",
    "Ägypten","",
    "<U+0391><U+03AF><U+03B3><U+03C5>pt<U+03BF>","",
    "<U+0645><U+0635><U+0631>"
)
test_PCRE<-'testing PCRE for 8 languages'
test_PCRE
counter<-0
for(i in seq(1,16,2)){
    PCRE= regexpr(enc2utf8(testspace[i+1]), enc2utf8(testspace[i]), perl=TRUE)
    if(PCRE[1]==results_to_be_checked[i] & attr(PCRE, "match.length")==results_to_be_checked[i+1])
        counter = counter + 1
}
sprintf("%d tests passsed out of 8 ", counter)


test_TRE<-'testing TRE for 8 languages'
test_TRE
counter<-0
for(i in seq(1,16,2)){
    TRE= regexpr(enc2utf8(testspace[i+1]), enc2utf8(testspace[i]), perl=FALSE)
    if(TRE[1]==results_to_be_checked[i] & attr(TRE, "match.length")==results_to_be_checked[i+1])
        counter = counter + 1
}
sprintf("%d tests passsed out of 8 ", counter)


test_ICU<-'testing ICU for 8 languages'
test_ICU
counter<-0
for(i in seq(1,16,2)){
    ICU= stringi::stri_match( enc2utf8(testspace[i]), regex=enc2utf8(testspace[i+1]))
    if(enc2native(ICU[1,1]) == results_to_be_checked_ICU[i])
        counter = counter + 1
}
sprintf("%d tests passsed out of 8 ", counter)
