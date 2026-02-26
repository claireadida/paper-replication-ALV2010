log using "/Users/claireadida/Desktop/France Documents/March 2009/Analysis/Survey/SurveyDataForPNAS.smcl", replace*********************************** Large-N Survey Data* Showing how Muslims and Christians at the same starting point end up in different places**********************************clear allset mem 1guse "/Users/claireadida/Desktop/France Documents/March 2009/Analysis/Survey/SurveyData.dta"gen gender=sexereplace gender=0 if gender==1replace gender=1 if gender==2label define gender 0 male 1 femalegen Age=age1gen family_muslim=1 if q7==1replace family_muslim=0 if family_muslim==.replace family_muslim=. if q7==.gen family_christian=1 if q7==2replace family_christian=0 if family_christian==.replace family_christian=. if q7==.gen family_religion=q7label define family_religion 1 muslim 2 christiangen family_tidjane=1 if q11==1replace family_tidjane=0 if family_tidjane==.replace family_tidjane=. if q11==99 | q11==.gen generation=1 if (q13==5 | q13==6)replace generation=2 if (q13==4 | q13==3 | q13==2 | q13==1)replace generation=3 if q13==7replace generation=. if q13==99gen educ_firstmigrant=q15replace educ_firstmigrant=. if q15==99gen firstmigrant_farmer_sen=1 if q16b==1replace firstmigrant_farmer_sen=0 if firstmigrant_farmer_sen==.replace firstmigrant_farmer_sen=. if q16b==. | q16b==99gen firstmigrant_salaried_sen=1 if q16b==2replace firstmigrant_salaried_sen=0 if firstmigrant_salaried_sen==.replace firstmigrant_salaried_sen=. if q16b==. | q16b==99gen firstmigrant_merchant_sen=3 if q16b==2replace firstmigrant_merchant_sen=0 if firstmigrant_merchant_sen==.replace firstmigrant_merchant_sen=. if q16b==. | q16b==99gen firstmigrant_farmer_fr=1 if q18b==1replace firstmigrant_farmer_fr=0 if firstmigrant_farmer_fr==.replace firstmigrant_farmer_fr=. if q18b==99 | q18b==.gen firstmigrant_prof_fr=1 if q18b==3replace firstmigrant_prof_fr=0 if firstmigrant_prof_fr==.replace firstmigrant_prof_fr=. if q18b==99 | q18b==.gen firstmigrant_intermed_fr=1 if q18b==4replace firstmigrant_intermed_fr=0 if firstmigrant_intermed_fr==.replace firstmigrant_intermed_fr=. if q18b==99 | q18b==.gen french_national=1 if q39==1replace french_national=0 if french_national==.replace french_national=. if q39==.gen self_farmer_now=1 if q41b==1replace self_farmer_now=0 if self_farmer_now==.replace self_farmer_now=. if q41b==.gen self_prof_now=1 if q41b==3replace self_prof_now=0 if self_prof_now==.replace self_prof_now=. if q41b==.gen self_intermed_now=1 if q41b==4replace self_intermed_now=0 if self_intermed_now==.replace self_intermed_now=. if q41b==.gen self_educ_now=q43replace self_educ_now=. if q43==99gen self_muslim=1 if q53==1replace self_muslim=0 if self_muslim==.replace self_muslim=. if q53==.gen self_christian=1 if q53==2replace self_christian=0 if self_christian==.replace self_christian=. if q53==.gen self_religion=q53replace self_religion=0 if self_religion==1replace self_religion=1 if self_religion==2label define self_religion 0 muslim 1 christian/*gen self_tidjane=1 if q54a==1replace self_tidjane=0 if self_tidjane==.replace self_tidjane=. if q54a==.gen group1=1 if self_tidjane==1replace group1=2 if self_christian==1label define group1 1 tidjane 2 christiangen remittances=q64replace remittances=. if q64==99gen income=q95replace income=. if q95==99ttest income, by(group1)ttest french_national, by(group1)ttest educ_firstmigrant, by(group1)ttest firstmigrant_farmer_sen, by(group1)ttest firstmigrant_salaried_sen, by(group1)gen group1bis=1 if family_tidjane==1replace group1bis=2 if family_christian==1ttest income, by(group1bis)ttest educ_firstmigrant, by(group1bis)*/gen income=q95replace income=. if q95==99reg income educ_firstmigrant self_religion gender Age, robustsummarize income educ_firstmigrant self_religion gender Age** What David ran and what is currently in PNAS Table 2gen david_religion=0 if q7==1 & q53==1replace david_religion=1 if q7==2 & q53==2oprobit q95 q15 gender age1 david_religion if q95~=99 & q15~=99, robustgen interaction=david_religion*q15oprobit q95 q15 gender age1 david_religion interaction if q95~=99 & q15~=99, robust** UPDATE July 2010: How we got our Table A4 for PNAS paper

clear allset mem 1guse "/Users/claireadida/Desktop/France Documents/Papers/Social Sanctioning/Analysis/Datasets/SurveyData.dta", replacegen income=q95 if q95<99gen christianfamily=1 if q7==2 // family tradition is rather christianreplace christianfamily=0 if q7==1 // family tradition is rather muslim
label define christianfamilylabels 0 "muslim" 1 "christian"
label values christianfamily christianfamilylabelsgen gender=sexereplace gender=0 if gender==1replace gender=1 if gender==2label define genderlabels 0 "male" 1 "female"
label values gender genderlabelsgen female=1 if gender==1replace female=0 if female==.gen genderhead=1 if (q40=="01" & female==0)|q40=="03" // respondent is male head of hh or head of hh is respondent's fatherreplace genderhead=0 if (q40=="01" & female==1)|q40=="04" // respondent is female head of hh or head of hh is resp's mother
label define genderheadlabels 0 "femalehouseholdhead" 1 "malehouseholdhead"
label values genderhead genderheadlabelsgen curreduc=q43 if q43<99
label define curreduclabels 1 "none" 2 "primary" 3 "middle" 4 "middle tech" 5 "secondary tech" 6 "secondary" 7 "some undergrad" 8 "undergrad+"
label values curreduc curreduclabelsgen educhead=curreduc if q40=="01" // head of hh's education if respondent is head of hhgen educfather=q36replace educfather=. if educfather==99
label define educfatherlabels 1 "none" 2 "primary" 3 "middle" 4 "middle tech" 5 "secondary tech" 6 "secondary" 7 "some undergrad" 8 "undergrad+"
label values educfather educfatherlabelsgen educmother=q37replace educmother=. if educmother==99
label define educmotherlabels 1 "none" 2 "primary" 3 "middle" 4 "middle tech" 5 "secondary tech" 6 "secondary" 7 "some undergrad" 8 "undergrad+"
label values educmother educmotherlabelsreplace educhead=educfather if q40=="03"replace educhead=educmother if q40=="04"gen initialeduc=q15 if q15<99
label define initialeduclabels 1 "none" 2 "primary" 3 "middle tech" 4 "some secondary" 5 "secondary" 6 "post sec"
label values initialeduc initialeduclabels

gen numberchildren=q49** Results for PNAS paperoprobit income christianfamily genderhead educhead initialeduc if q40=="01"|q40=="03"|q40=="04", ro
mfx, nonlinear predict (p outcome(1))
mfx, nonlinear predict (p outcome(2))
mfx, nonlinear predict (p outcome(3))
mfx, nonlinear predict (p outcome(4))
mfx, nonlinear predict (p outcome(5))
mfx, nonlinear predict (p outcome(6))
mfx, nonlinear predict (p outcome(7))
mfx, nonlinear predict (p outcome(8))
mfx, nonlinear predict (p outcome(9))
** what is predicted probability of reaching each income category (there are 9 of them)?
oprobit income christianfamily genderhead educhead initialeduc if q40=="01"|q40=="03"|q40=="04", ro
predict p1 p2 p3 p4 p5 p6 p7 p8 p9
** now let's calculate the predicted probability of reaching each income category for the typical Christian vs. typical Muslim
*** typical Muslim (by mode)
egen modegenderheadMuslim=mode(genderhead) if christianfamily==0
summarize modegenderheadMuslim // 1
egen modeeducheadMuslim=mode(educhead) if christianfamily==0
summarize modeeducheadMuslim // 1
egen modeinitialeducMuslim=mode(initialeduc) if christianfamily==0
summarize modeinitialeducMuslim //1
*** typical Christian (by mode)
egen modegenderheadChristian=mode(genderhead) if christianfamily==1
summarize modegenderheadChristian // 1
egen modeeducheadChristian=mode(educhead) if christianfamily==1
summarize modeeducheadChristian // 8
egen modeinitialeducChristian=mode(initialeduc) if christianfamily==1
summarize modeinitialeducChristian //1

summarize p1 if christianfamily==0 & genderhead==modegenderheadMuslim & educhead==modeeducheadMuslim & initialeduc==modeinitialeducMuslim
summarize p1 if christianfamily==1 & genderhead==modegenderheadChristian & educhead==modeeducheadChristian & initialeduc==modeinitialeducChristian

summarize p2 if christianfamily==0 & genderhead==modegenderheadMuslim & educhead==modeeducheadMuslim & initialeduc==modeinitialeducMuslim
summarize p2 if christianfamily==1 & genderhead==modegenderheadChristian & educhead==modeeducheadChristian & initialeduc==modeinitialeducChristian

summarize p3 if christianfamily==0 & genderhead==modegenderheadMuslim & educhead==modeeducheadMuslim & initialeduc==modeinitialeducMuslim
summarize p3 if christianfamily==1 & genderhead==modegenderheadChristian & educhead==modeeducheadChristian & initialeduc==modeinitialeducChristian

summarize p4 if christianfamily==0 & genderhead==modegenderheadMuslim & educhead==modeeducheadMuslim & initialeduc==modeinitialeducMuslim
summarize p4 if christianfamily==1 & genderhead==modegenderheadChristian & educhead==modeeducheadChristian & initialeduc==modeinitialeducChristian

summarize p5 if christianfamily==0 & genderhead==modegenderheadMuslim & educhead==modeeducheadMuslim & initialeduc==modeinitialeducMuslim
summarize p5 if christianfamily==1 & genderhead==modegenderheadChristian & educhead==modeeducheadChristian & initialeduc==modeinitialeducChristian

summarize p6 if christianfamily==0 & genderhead==modegenderheadMuslim & educhead==modeeducheadMuslim & initialeduc==modeinitialeducMuslim
summarize p6 if christianfamily==1 & genderhead==modegenderheadChristian & educhead==modeeducheadChristian & initialeduc==modeinitialeducChristian

summarize p7 if christianfamily==0 & genderhead==modegenderheadMuslim & educhead==modeeducheadMuslim & initialeduc==modeinitialeducMuslim
summarize p7 if christianfamily==1 & genderhead==modegenderheadChristian & educhead==modeeducheadChristian & initialeduc==modeinitialeducChristian

summarize p8 if christianfamily==0 & genderhead==modegenderheadMuslim & educhead==modeeducheadMuslim & initialeduc==modeinitialeducMuslim
summarize p8 if christianfamily==1 & genderhead==modegenderheadChristian & educhead==modeeducheadChristian & initialeduc==modeinitialeducChristian

summarize p9 if christianfamily==0 & genderhead==modegenderheadMuslim & educhead==modeeducheadMuslim & initialeduc==modeinitialeducMuslim
summarize p9 if christianfamily==1 & genderhead==modegenderheadChristian & educhead==modeeducheadChristian & initialeduc==modeinitialeducChristian



*** typical Muslim (by mean +/- 1 SD)
egen SDMusgenderhead=sd(genderhead) if christianfamily==0
egen meanMusgenderhead=mean(genderhead) if christianfamily==0
gen lowtypeMusgenderhead=meanMusgenderhead - 0.5*SDMusgenderhead
gen hightypeMusgenderhead=meanMusgenderhead + 0.5*SDMusgenderhead


egen SDMuseduchead=sd(educhead) if christianfamily==0
egen meanMuseduchead=mean(educhead) if christianfamily==0
gen lowtypeMuseduchead=meanMuseduchead - 0.5*SDMuseduchead
gen hightypeMuseduchead=meanMuseduchead + 0.5*SDMuseduchead

egen SDMusinitialeduc=sd(initialeduc) if christianfamily==0
egen meanMusinitialeduc=mean(initialeduc) if christianfamily==0
gen lowtypeMusinitialeduc=meanMusinitialeduc - 0.5*SDMusinitialeduc
gen hightypeMusinitialeduc=meanMusinitialeduc + 0.5*SDMusinitialeduc

*** typical Christian (by mean +/- 1SD)
egen SDChrisgenderhead=sd(genderhead) if christianfamily==1
egen meanChrisgenderhead=mean(genderhead) if christianfamily==1
gen lowtypeChrisgenderhead=meanChrisgenderhead - 0.5*SDChrisgenderhead
gen hightypeChrisgenderhead=meanChrisgenderhead + 0.5*SDChrisgenderhead


egen SDChriseduchead=sd(educhead) if christianfamily==1
egen meanChriseduchead=mean(educhead) if christianfamily==1
gen lowtypeChriseduchead=meanChriseduchead - 0.5*SDChriseduchead
gen hightypeChriseduchead=meanChriseduchead + 0.5*SDChriseduchead

egen SDChrisinitialeduc=sd(initialeduc) if christianfamily==1
egen meanChrisinitialeduc=mean(initialeduc) if christianfamily==1
gen lowtypeChrisinitialeduc=meanChrisinitialeduc - 0.5*SDChrisinitialeduc
gen hightypeChrisinitialeduc=meanChrisinitialeduc + 0.5*SDChrisinitialeduc

summarize p1 if christianfamily==0 & lowtypeMusgenderhead<=genderhead<=hightypeMusgenderhead & lowtypeMuseduchead<=educhead<=hightypeMuseduchead & lowtypeMusinitialeduc<=initialeduc<=hightypeMusinitialeduc
summarize p1 if christianfamily==1 & lowtypeChrisgenderhead<=genderhead<=hightypeChrisgenderhead & lowtypeChriseduchead<=educhead<=hightypeChriseduchead & lowtypeChrisinitialeduc<=initialeduc<=hightypeChrisinitialeduc

summarize p2 if christianfamily==0 & lowtypeMusgenderhead<=genderhead<=hightypeMusgenderhead & lowtypeMuseduchead<=educhead<=hightypeMuseduchead & lowtypeMusinitialeduc<=initialeduc<=hightypeMusinitialeduc
summarize p2 if christianfamily==1 & lowtypeChrisgenderhead<=genderhead<=hightypeChrisgenderhead & lowtypeChriseduchead<=educhead<=hightypeChriseduchead & lowtypeChrisinitialeduc<=initialeduc<=hightypeChrisinitialeduc

summarize p3 if christianfamily==0 & lowtypeMusgenderhead<=genderhead<=hightypeMusgenderhead & lowtypeMuseduchead<=educhead<=hightypeMuseduchead & lowtypeMusinitialeduc<=initialeduc<=hightypeMusinitialeduc
summarize p3 if christianfamily==1 & lowtypeChrisgenderhead<=genderhead<=hightypeChrisgenderhead & lowtypeChriseduchead<=educhead<=hightypeChriseduchead & lowtypeChrisinitialeduc<=initialeduc<=hightypeChrisinitialeduc

summarize p4 if christianfamily==0 & lowtypeMusgenderhead<=genderhead<=hightypeMusgenderhead & lowtypeMuseduchead<=educhead<=hightypeMuseduchead & lowtypeMusinitialeduc<=initialeduc<=hightypeMusinitialeduc
summarize p4 if christianfamily==1 & lowtypeChrisgenderhead<=genderhead<=hightypeChrisgenderhead & lowtypeChriseduchead<=educhead<=hightypeChriseduchead & lowtypeChrisinitialeduc<=initialeduc<=hightypeChrisinitialeduc

summarize p5 if christianfamily==0 & lowtypeMusgenderhead<=genderhead<=hightypeMusgenderhead & lowtypeMuseduchead<=educhead<=hightypeMuseduchead & lowtypeMusinitialeduc<=initialeduc<=hightypeMusinitialeduc
summarize p5 if christianfamily==1 & lowtypeChrisgenderhead<=genderhead<=hightypeChrisgenderhead & lowtypeChriseduchead<=educhead<=hightypeChriseduchead & lowtypeChrisinitialeduc<=initialeduc<=hightypeChrisinitialeduc

summarize p6 if christianfamily==0 & lowtypeMusgenderhead<=genderhead<=hightypeMusgenderhead & lowtypeMuseduchead<=educhead<=hightypeMuseduchead & lowtypeMusinitialeduc<=initialeduc<=hightypeMusinitialeduc
summarize p6 if christianfamily==1 & lowtypeChrisgenderhead<=genderhead<=hightypeChrisgenderhead & lowtypeChriseduchead<=educhead<=hightypeChriseduchead & lowtypeChrisinitialeduc<=initialeduc<=hightypeChrisinitialeduc

summarize p7 if christianfamily==0 & lowtypeMusgenderhead<=genderhead<=hightypeMusgenderhead & lowtypeMuseduchead<=educhead<=hightypeMuseduchead & lowtypeMusinitialeduc<=initialeduc<=hightypeMusinitialeduc
summarize p7 if christianfamily==1 & lowtypeChrisgenderhead<=genderhead<=hightypeChrisgenderhead & lowtypeChriseduchead<=educhead<=hightypeChriseduchead & lowtypeChrisinitialeduc<=initialeduc<=hightypeChrisinitialeduc

summarize p8 if christianfamily==0 & lowtypeMusgenderhead<=genderhead<=hightypeMusgenderhead & lowtypeMuseduchead<=educhead<=hightypeMuseduchead & lowtypeMusinitialeduc<=initialeduc<=hightypeMusinitialeduc
summarize p8 if christianfamily==1 & lowtypeChrisgenderhead<=genderhead<=hightypeChrisgenderhead & lowtypeChriseduchead<=educhead<=hightypeChriseduchead & lowtypeChrisinitialeduc<=initialeduc<=hightypeChrisinitialeduc

summarize p9 if christianfamily==0 & lowtypeMusgenderhead<=genderhead<=hightypeMusgenderhead & lowtypeMuseduchead<=educhead<=hightypeMuseduchead & lowtypeMusinitialeduc<=initialeduc<=hightypeMusinitialeduc
summarize p9 if christianfamily==1 & lowtypeChrisgenderhead<=genderhead<=hightypeChrisgenderhead & lowtypeChriseduchead<=educhead<=hightypeChriseduchead & lowtypeChrisinitialeduc<=initialeduc<=hightypeChrisinitialeduc

** now let's calculate the predicted probability of reaching each income category for the typical person (by mode), varying only X/M
egen modegenderhead=mode(genderhead)
egen modeeduchead=mode(educhead)
egen modeinitialeduc=mode(initialeduc)

summarize p1 if christianfamily==0 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc
summarize p1 if christianfamily==1 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc

summarize p2 if christianfamily==0 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc
summarize p2 if christianfamily==1 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc

summarize p3 if christianfamily==0 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc
summarize p3 if christianfamily==1 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc

summarize p4 if christianfamily==0 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc
summarize p4 if christianfamily==1 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc

summarize p5 if christianfamily==0 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc
summarize p5 if christianfamily==1 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc

summarize p6 if christianfamily==0 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc
summarize p6 if christianfamily==1 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc

summarize p7 if christianfamily==0 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc
summarize p7 if christianfamily==1 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc

summarize p8 if christianfamily==0 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc
summarize p8 if christianfamily==1 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc

summarize p9 if christianfamily==0 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc
summarize p9 if christianfamily==1 & genderhead==modegenderhead & educhead==modeeduchead & initialeduc==modeinitialeduc

** now let's calculate the predicted probability of reaching each income category for the typical person (by mean +/- 1SD), varying only X/M
egen SDgenderhead=sd(genderhead)
egen meangenderhead=mean(genderhead)
gen lowtypegenderhead=meangenderhead-0.5*SDgenderhead
gen hightypegenderhead=meangenderhead+0.5*SDgenderhead

egen SDeduchead=sd(educhead)
egen meaneduchead=mean(educhead)
gen lowtypeeduchead=meaneduchead-0.5*SDeduchead
gen hightypeeduchead=meaneduchead+0.5*SDeduchead

egen SDinitialeduc=sd(initialeduc)
egen meaninitialeduc=mean(initialeduc)
gen lowtypeinitialeduc=meaninitialeduc -0.5*SDinitialeduc
gen hightypeinitialeduc=meaninitialeduc + 0.5*SDinitialeduc

summarize p1 if christianfamily==0 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc
summarize p1 if christianfamily==1 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc

summarize p2 if christianfamily==0 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc
summarize p2 if christianfamily==1 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc

summarize p3 if christianfamily==0 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc
summarize p3 if christianfamily==1 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc

summarize p4 if christianfamily==0 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc
summarize p4 if christianfamily==1 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc

summarize p5 if christianfamily==0 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc
summarize p5 if christianfamily==1 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc

summarize p6 if christianfamily==0 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc
summarize p6 if christianfamily==1 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc

summarize p7 if christianfamily==0 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc
summarize p7 if christianfamily==1 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc

summarize p8 if christianfamily==0 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc
summarize p8 if christianfamily==1 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc

summarize p9 if christianfamily==0 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc
summarize p9 if christianfamily==1 & lowtypegenderhead<=genderhead<=hightypegenderhead & lowtypeeduchead<=educhead<=hightypeeduchead & lowtypeinitialeduc<=initialeduc<=hightypeinitialeduc








log close