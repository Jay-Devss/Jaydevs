--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.8) ~  Much Love, Ferib 

]]--

local v0=tonumber;local v1=string.byte;local v2=string.char;local v3=string.sub;local v4=string.gsub;local v5=string.rep;local v6=table.concat;local v7=table.insert;local v8=math.ldexp;local v9=getfenv or function() return _ENV;end ;local v10=setmetatable;local v11=pcall;local v12=select;local v13=unpack or table.unpack ;local v14=tonumber;local function v15(v16,v17,...) local v18=1;local v19;v16=v4(v3(v16,5),"..",function(v30) if (v1(v30,2)==81) then v19=v0(v3(v30,1,1));return "";else local v81=v2(v0(v30,16));if v19 then local v93=0;local v94;while true do if (v93==1) then return v94;end if (v93==0) then v94=v5(v81,v19);v19=nil;v93=1;end end else return v81;end end end);local function v20(v31,v32,v33) if v33 then local v82=0;local v83;while true do if (v82==(0 -0)) then v83=(v31/((5 -(3 + 0))^(v32-1)))%((3 -1)^(((v33-(2 -1)) -(v32-(620 -((790 -235) + 64)))) + 1)) ;return v83-(v83%(932 -(857 + (1711 -(1523 + 114))))) ;end end else local v84=568 -(367 + 201) ;local v85;while true do if (v84==(927 -(214 + 713))) then v85=(1 + 1)^(v32-(1 + (1065 -(68 + 997)))) ;return (((v31%(v85 + v85))>=v85) and 1) or ((2147 -(226 + 1044)) -(282 + 595)) ;end end end end local function v21() local v34=0 -0 ;local v35;while true do if (v34==(117 -(32 + 85))) then v35=v1(v16,v18,v18);v18=v18 + (958 -(892 + 65)) ;v34=1 + 0 ;end if (v34==((2 -1) + 0)) then return v35;end end end local function v22() local v36=(0 -0) -0 ;local v37;local v38;while true do if (v36==(0 -0)) then v37,v38=v1(v16,v18,v18 + (352 -(87 + 263)) );v18=v18 + (182 -(67 + 113)) ;v36=1 + 0 ;end if (v36==(2 -1)) then return (v38 * (189 + 67)) + v37 ;end end end local function v23() local v39,v40,v41,v42=v1(v16,v18,v18 + (955 -(802 + 150)) );v18=v18 + 4 ;return (v42 * 16777216) + (v41 * (176444 -110908)) + (v40 * (464 -208)) + v39 ;end local function v24() local v43=v23();local v44=v23();local v45=1 + 0 ;local v46=(v20(v44,(1436 -(145 + 293)) -(915 + 82) ,20) * ((5 -3)^(19 + 13))) + v43 ;local v47=v20(v44,27 -6 ,1218 -(1069 + 118) );local v48=((v20(v44,72 -(470 -(44 + 386)) )==(1 -0)) and  -(1 + 0)) or (1 -0) ;if (v47==(0 + 0)) then if (v46==((2277 -(998 + 488)) -(368 + 423))) then return v48 * (0 -(0 + 0)) ;else v47=1;v45=18 -(10 + 8) ;end elseif (v47==2047) then return ((v46==0) and (v48 * ((3 -2)/(442 -(416 + 26))))) or (v48 * NaN) ;end return v8(v48,v47-(3266 -2243) ) * (v45 + (v46/((1 + 0 + 1)^(91 -39)))) ;end local function v25(v49) local v50;if  not v49 then local v86=772 -(201 + 571) ;while true do if ((1138 -(116 + 1022))==v86) then v49=v23();if (v49==((0 -0) -(0 -0))) then return "";end break;end end end v50=v3(v16,v18,(v18 + v49) -1 );v18=v18 + v49 ;local v51={};for v65=1 + (859 -(814 + 45)) , #v50 do v51[v65]=v2(v1(v3(v50,v65,v65)));end return v6(v51);end local v26=v23;local function v27(...) return {...},v12("#",...);end local function v28() local v52=(function() return 0;end)();local v53=(function() return;end)();local v54=(function() return;end)();local v55=(function() return;end)();local v56=(function() return;end)();local v57=(function() return;end)();local v58=(function() return;end)();while true do if ((1 + 1)==v52) then for v95= #"[",v23() do local v96=(function() return v21();end)();if (v20(v96, #"!", #"[")~=(0 + 0)) then else local v103=(function() return 0 -0 ;end)();local v104=(function() return;end)();local v105=(function() return;end)();local v106=(function() return;end)();while true do if (v103~=0) then else local v112=(function() return 0 -0 ;end)();while true do if (v112==1) then v103=(function() return 1;end)();break;end if ((374 -(123 + 251))==v112) then v104=(function() return v20(v96,2, #"91(");end)();v105=(function() return v20(v96, #"?id=",6);end)();v112=(function() return 4 -3 ;end)();end end end if (v103==(699 -(208 + 490))) then local v113=(function() return 0 + 0 ;end)();local v114=(function() return;end)();while true do if (v113==0) then v114=(function() return 0 + 0 ;end)();while true do if (v114==(836 -(660 + 176))) then v106=(function() return {v22(),v22(),nil,nil};end)();if (v104==(202 -(14 + 188))) then local v564=(function() return 675 -(534 + 141) ;end)();local v565=(function() return;end)();while true do if (v564==0) then v565=(function() return 0;end)();while true do if ((0 + 0)~=v565) then else v106[ #"asd"]=(function() return v22();end)();v106[ #"?id="]=(function() return v22();end)();break;end end break;end end elseif (v104== #"~") then v106[ #"-19"]=(function() return v23();end)();elseif (v104==2) then v106[ #"asd"]=(function() return v23() -(2^(15 + 1)) ;end)();elseif (v104== #"gha") then local v817=(function() return 0;end)();local v818=(function() return;end)();while true do if (v817~=(0 + 0)) then else v818=(function() return 0 -0 ;end)();while true do if (v818~=(0 -0)) then else v106[ #"asd"]=(function() return v23() -((5 -3)^16) ;end)();v106[ #".dev"]=(function() return v22();end)();break;end end break;end end end v114=(function() return 1 + 0 ;end)();end if (v114~=(1 + 0)) then else v103=(function() return 2;end)();break;end end break;end end end if (v103==(398 -(115 + 281))) then if (v20(v105, #">", #"|")== #"~") then v106[2]=(function() return v58[v106[4 -2 ]];end)();end if (v20(v105,2 + 0 ,4 -2 )== #"[") then v106[ #"xxx"]=(function() return v58[v106[ #"91("]];end)();end v103=(function() return 3;end)();end if (3~=v103) then else if (v20(v105, #"19(", #"xxx")== #">") then v106[ #"0313"]=(function() return v58[v106[ #"0836"]];end)();end v53[v95]=(function() return v106;end)();break;end end end end for v97= #"{",v23() do v54[v97-#"}" ]=(function() return v28();end)();end return v56;end if (v52~=(0 -0)) then else local v90=(function() return 0;end)();local v91=(function() return;end)();while true do if (0~=v90) then else v91=(function() return 0;end)();while true do if (1==v91) then v55=(function() return {};end)();v56=(function() return {v53,v54,nil,v55};end)();v91=(function() return 2;end)();end if (v91==2) then v52=(function() return  #"]";end)();break;end if (v91==0) then v53=(function() return {};end)();v54=(function() return {};end)();v91=(function() return 1;end)();end end break;end end end if (v52== #",") then local v92=(function() return 0 -0 ;end)();while true do if (v92==2) then v52=(function() return 2;end)();break;end if (v92==(0 -0)) then v57=(function() return v23();end)();v58=(function() return {};end)();v92=(function() return 1;end)();end if (v92~=(2 -1)) then else for v108= #">",v57 do local v109=(function() return 0;end)();local v110=(function() return;end)();local v111=(function() return;end)();while true do if (v109==(286 -(134 + 151))) then if (v110== #"/") then v111=(function() return v21()~=(1665 -(970 + 695)) ;end)();elseif (v110==2) then v111=(function() return v24();end)();elseif (v110== #"19(") then v111=(function() return v25();end)();end v58[v108]=(function() return v111;end)();break;end if (v109==(0 -0)) then local v117=(function() return 0;end)();while true do if (1==v117) then v109=(function() return 1;end)();break;end if (0~=v117) then else v110=(function() return v21();end)();v111=(function() return nil;end)();v117=(function() return 1991 -(582 + 1408) ;end)();end end end end end v56[ #"xxx"]=(function() return v21();end)();v92=(function() return 2;end)();end end end end end local function v29(v59,v60,v61) local v62=v59[3 -(2 + 0) ];local v63=v59[2];local v64=v59[3 -0 ];return function(...) local v67=v62;local v68=v63;local v69=v64;local v70=v27;local v71=3 -2 ;local v72= -(1825 -(1195 + 629));local v73={};local v74={...};local v75=v12("#",...) -1 ;local v76={};local v77={};for v87=241 -(187 + 54) ,v75 do if ((v87>=v69) or (3495>4306)) then v73[v87-v69 ]=v74[v87 + (781 -(162 + (1361 -743))) ];else v77[v87]=v74[v87 + (1 -0) + (176 -(50 + 126)) ];end end local v78=(v75-v69) + 1 ;local v79;local v80;while true do v79=v67[v71];v80=v79[1 + 0 ];if ((4001>3798) and (v80<=(100 -64))) then if (v80<=(35 -18)) then if (v80<=(13 -5)) then if (v80<=(1 + 2)) then if ((v80<=(1637 -(1373 + 263))) or (4688<=4499)) then if (v80>((222 + 778) -(451 + 549))) then if ((v77[v79[2]]==v77[v79[2 + 2 ]]) or (1567<=319)) then v71=v71 + 1 ;else v71=v79[4 -1 ];end else local v121;v77[v79[(1415 -(1233 + 180)) -0 ]]=v79[1387 -(746 + 638) ];v71=v71 + 1 + 0 ;v79=v67[v71];v77[v79[2 -0 ]]=v79[344 -(218 + 123) ];v71=v71 + (1582 -(1535 + 46)) ;v79=v67[v71];v121=v79[2 + 0 ];v77[v121](v13(v77,v121 + 1 + 0 ,v79[563 -(306 + 254) ]));v71=v71 + 1 ;v79=v67[v71];v77[v79[2]]=v60[v79[1 + 2 ]];v71=v71 + (1 -0) ;v79=v67[v71];v77[v79[1469 -((1868 -(522 + 447)) + 568) ]]=v79[2 + 1 ];v71=v71 + ((1423 -(107 + 1314)) -1) ;v79=v67[v71];v121=v79[2];v77[v121](v77[v121 + (604 -(268 + 335)) ]);v71=v71 + (291 -(60 + 230)) ;v79=v67[v71];v77[v79[574 -(198 + 228 + 146) ]]=v79[3];end elseif (v80>(1 + 1)) then local v135=v79[1458 -(282 + 1174) ];local v136,v137=v70(v77[v135](v77[v135 + (812 -(569 + 242)) ]));v72=(v137 + v135) -(2 -1) ;local v138=0 + 0 ;for v439=v135,v72 do v138=v138 + (1025 -(706 + 318)) ;v77[v439]=v136[v138];end else v77[v79[(3817 -2564) -(307 + 414 + 530) ]]=v77[v79[1274 -((1876 -931) + (1289 -963)) ]][v79[4]];end elseif (v80<=(12 -(1917 -(716 + 1194)))) then if (v80>4) then local v141;v77[v79[2]]=v61[v79[3 + 0 + 0 ]];v71=v71 + (701 -(271 + 429)) ;v79=v67[v71];v77[v79[2 + 0 ]]=v77[v79[1503 -(1408 + 92) ]][v79[1090 -(461 + 625) ]];v71=v71 + 1 ;v79=v67[v71];v77[v79[1290 -(993 + 295) ]]=v77[v79[1 + 1 + 1 ]];v71=v71 + (1172 -((921 -(74 + 429)) + 753)) ;v79=v67[v71];v141=v79[2];v77[v141](v77[v141 + 1 ]);v71=v71 + 1 + 0 ;v79=v67[v71];v77[v79[1 + 1 ]]=v61[v79[3]];v71=v71 + 1 + 0 ;v79=v67[v71];v141=v79[2];v77[v141]=v77[v141]();v71=v71 + 1 + 0 ;v79=v67[v71];v77[v79[531 -(406 + 123) ]]=v77[v79[3]][v79[(3419 -1646) -(1749 + 20) ]];v71=v71 + 1 ;v79=v67[v71];if v77[v79[1 + 1 + 0 ]] then v71=v71 + (1323 -((2858 -1609) + 73)) ;else v71=v79[2 + 0 + 1 ];end else local v155;v77[v79[1147 -(466 + 679) ]]=v77[v79[6 -3 ]][v79[11 -(21 -14) ]];v71=v71 + (1901 -(106 + 1794)) ;v79=v67[v71];v77[v79[1 + 1 ]]=v79[3];v71=v71 + 1 ;v79=v67[v71];v155=v79[1 + 1 ];v77[v155](v77[v155 + (2 -1) ]);v71=v71 + (2 -(2 -1)) ;v79=v67[v71];v77[v79[(549 -(279 + 154)) -((782 -(454 + 324)) + 110) ]]=v60[v79[587 -(57 + 527) ]];v71=v71 + (1428 -(41 + 1386)) ;v79=v67[v71];v77[v79[(83 + 22) -((34 -(12 + 5)) + 86) ]]=v79[3 + 0 ];v71=v71 + ((1 + 0) -0) ;v79=v67[v71];v155=v79[2];v77[v155](v77[v155 + (2 -1) ]);v71=v71 + 1 ;v79=v67[v71];v77[v79[2]]=v60[v79[169 -(122 + 44) ]];v71=v71 + (1 -0) ;v79=v67[v71];v155=v79[6 -4 ];v77[v155]=v77[v155]();v71=v71 + 1 + 0 ;v79=v67[v71];if v77[v79[2]] then v71=v71 + 1 + 0 ;else v71=v79[3];end end elseif ((v80<=(11 -5)) or (4583==3761)) then local v171;v77[v79[67 -(30 + 35) ]]=v77[v79[3 + 0 ]][v79[(3212 -1951) -(1043 + 214) ]];v71=v71 + (3 -2) ;v79=v67[v71];v77[v79[2]][v79[3]]=v77[v79[(450 + 766) -(323 + 889) ]];v71=v71 + (2 -1) ;v79=v67[v71];v77[v79[582 -(361 + 219) ]]=v60[v79[323 -(53 + (1360 -(277 + 816))) ]];v71=v71 + 1 ;v79=v67[v71];v77[v79[1 + 1 ]]=v77[v79[416 -(15 + 398) ]];v71=v71 + 1 ;v79=v67[v71];v171=v79[8 -6 ];v77[v171](v77[v171 + (983 -(18 + 964)) ]);v71=v71 + ((1186 -(1058 + 125)) -2) ;v79=v67[v71];v77[v79[1 + 1 + (975 -(815 + 160)) ]]=v79[2 + 1 ];elseif (v80>7) then v77[v79[2]][v79[853 -(20 + 830) ]]=v77[v79[4 + 0 ]];else local v460;local v461;v461=v79[8 -6 ];v460=v77[v79[7 -4 ]];v77[v461 + (127 -(116 + 10)) ]=v460;v77[v461]=v460[v79[1 + 3 ]];v71=v71 + (739 -(542 + 196)) ;v79=v67[v71];v77[v79[3 -1 ]]=v79[1 + 2 ];v71=v71 + 1 + 0 ;v79=v67[v71];v461=v79[1 + 1 ];v77[v461]=v77[v461](v13(v77,v461 + (2 -1) ,v79[3]));v71=v71 + 1 ;v79=v67[v71];v77[v79[2]]=v77[v79[(2 + 5) -4 ]];v71=v71 + (1552 -(1126 + 425)) ;v79=v67[v71];v460=v77[v79[409 -(118 + 287) ]];if v460 then v71=v71 + ((8 -5) -2) ;else v77[v79[1123 -((2016 -(41 + 1857)) + (2896 -(1222 + 671))) ]]=v460;v71=v79[8 -5 ];end end elseif ((3454>1580) and (v80<=(389 -(142 + 235)))) then if (v80<=(45 -35)) then if (v80>9) then local v184=0 + 0 ;local v185;local v186;while true do if ((977 -(553 + 424))==v184) then v185=nil;v186=nil;v77[v79[3 -1 ]]=v60[v79[3 + 0 ]];v71=v71 + 1 + 0 ;v184=1 + 0 ;end if (v184==(1 + 1)) then v77[v186]=v185[v79[3 + 1 ]];v71=v71 + (2 -(2 -1)) ;v79=v67[v71];v77[v79[(6 -1) -3 ]]={};v184=6 -(1185 -(229 + 953)) ;end if ((v184==(1778 -(1111 + 663))) or (1607==20)) then v79=v67[v71];v77[v79[1 + 1 ]][v79[14 -11 ]]=v77[v79[757 -((1818 -(874 + 705)) + 514) ]];v71=v71 + 1 + 0 ;v79=v67[v71];v184=1334 -(797 + 532) ;end if (v184==(1 + 2)) then v71=v71 + 1 ;v79=v67[v71];v77[v79[2 + 0 ]][v79[2 + 1 ]]=v79[4];v71=v71 + (2 -1) ;v184=1206 -(373 + 829) ;end if (v184==1) then v79=v67[v71];v186=v79[733 -(476 + 255) ];v185=v77[v79[3]];v77[v186 + (1131 -(369 + 761)) ]=v185;v184=2 + 0 ;end if ((v184==5) or (962>=4666)) then v185=v77[v79[6 -2 ]];if ( not v185 or (1896==1708)) then v71=v71 + (1 -(0 + 0)) ;else local v761=238 -(64 + 174) ;while true do if (v761==(0 + 0)) then v77[v79[2 -(0 -0) ]]=v185;v71=v79[339 -(144 + 192) ];break;end end end break;end end else local v187=0;local v188;local v189;while true do if (v187==(217 -(42 + 174))) then for v751=1 + 0 , #v76 do local v752=v76[v751];for v762=0 + 0 + 0 , #v752 do local v763=v752[v762];local v764=v763[(680 -(642 + 37)) + 0 ];local v765=v763[1506 -(363 + 1141) ];if ((v764==v77) and (v765>=v188)) then v189[v765]=v764[v765];v763[1581 -(1183 + 397) ]=v189;end end end break;end if ((3985>=1284) and (v187==(0 -0))) then v188=v79[2 + 0 ];v189={};v187=1 + 0 + 0 ;end end end elseif (v80>(1986 -(1913 + 62))) then if (v77[v79[2 + 0 ]]~=v79[10 -6 ]) then v71=v71 + (1934 -(565 + 1368)) ;else v71=v79[3];end else local v190=0 -0 ;local v191;while true do if ((v190==6) or (1987==545)) then v77[v79[1663 -(1477 + 184) ]]=v79[3 -0 ];break;end if (v190==(4 + 0)) then v79=v67[v71];v77[v79[(138 + 720) -(564 + 292) ]]=v79[4 -1 ];v71=v71 + (2 -1) ;v79=v67[v71];v190=5;end if ((v190==(306 -(244 + 60))) or (4896<1261)) then v77[v191](v13(v77,v191 + 1 + (0 -0) ,v79[(933 -(233 + 221)) -(41 + 435) ]));v71=v71 + 1 ;v79=v67[v71];v77[v79[(2319 -1316) -(938 + 63) ]]=v61[v79[3 + 0 ]];v190=1128 -(936 + 167 + 22) ;end if ((23<3610) and (v190==(0 + 0))) then v191=nil;v77[v79[2]]=v77[v79[1616 -(1565 + 48) ]];v71=v71 + 1 + 0 ;v79=v67[v71];v190=(2680 -(718 + 823)) -(782 + 356) ;end if (5==v190) then v191=v79[269 -(176 + 91) ];v77[v191](v77[v191 + (2 -1) ]);v71=v71 + ((1 + 0) -0) ;v79=v67[v71];v190=1098 -((1780 -(266 + 539)) + 117) ;end if (((1878 -(157 + 1718))==v190) or (3911<2578)) then v71=v71 + 1 ;v79=v67[v71];v77[v79[2 + 0 ]]=v77[v79[10 -7 ]][v79[13 -9 ]];v71=v71 + (1019 -(697 + 321)) ;v190=10 -6 ;end if ((v190==(1 -0)) or (4238<87)) then v77[v79[2]]=v61[v79[3]];v71=v71 + (2 -1) ;v79=v67[v71];v191=v79[1 + 1 ];v190=3 -1 ;end end end elseif (v80<=(37 -23)) then if ((2538==2538) and (v80>(1240 -(322 + 905)))) then local v192=611 -(602 + 9) ;local v193;while true do if (v192==(1189 -(449 + 740))) then v193=v77[v79[4]];if  not v193 then v71=v71 + (873 -(826 + 46)) ;else v77[v79[949 -(245 + 702) ]]=v193;v71=v79[9 -(16 -10) ];end break;end end else local v194;v77[v79[1 + 1 ]][v79[1901 -(260 + 1638) ]]=v77[v79[4]];v71=v71 + (441 -(382 + (1283 -(636 + 589)))) ;v79=v67[v71];v77[v79[6 -4 ]]=v61[v79[3 + 0 ]];v71=v71 + 1 ;v79=v67[v71];v77[v79[3 -1 ]]=v77[v79[8 -5 ]][v79[1209 -((2140 -1238) + 303) ]];v71=v71 + (1 -0) ;v79=v67[v71];v77[v79[2]]=v79[6 -3 ];v71=v71 + 1 + (0 -0) ;v79=v67[v71];v194=v79[1692 -(1121 + 569) ];v77[v194](v77[v194 + (215 -(22 + 192)) ]);v71=v71 + (684 -(483 + 200)) ;v79=v67[v71];v77[v79[1465 -(1113 + 291 + 59) ]]=v79[8 -5 ];end elseif ((4122==4122) and (v80<=(20 -5))) then local v207=v79[2];local v208,v209=v70(v77[v207](v13(v77,v207 + (766 -(171 + 297 + 297)) ,v79[565 -(334 + 228) ])));v72=(v209 + v207) -(3 -2) ;local v210=(1015 -(657 + 358)) -0 ;for v442=v207,v72 do v210=v210 + (1 -(0 -0)) ;v77[v442]=v208[v210];end elseif (v80==(5 + 11)) then local v475=(537 -301) -(141 + 95) ;local v476;local v477;local v478;while true do if (v475==(1 + 0)) then v478={};v477=v10({},{__index=function(v796,v797) local v798=v478[v797];return v798[2 -1 ][v798[4 -2 ]];end,__newindex=function(v799,v800,v801) local v802=v478[v800];v802[1 + 0 ][v802[5 -3 ]]=v801;end});v475=2;end if (v475==(2 + 0)) then for v804=1 + 0 + 0 ,v79[5 -1 ] do v71=v71 + 1 + 0 ;local v805=v67[v71];if (v805[164 -(92 + 19 + 52) ]==((41 -27) + 13)) then v478[v804-((1833 -(1552 + 280)) -0) ]={v77,v805[3 + 0 ]};else v478[v804-(2 -1) ]={v60,v805[3]};end v76[ #v76 + (850 -(254 + 595)) ]=v478;end v77[v79[128 -(55 + 71) ]]=v29(v476,v477,v61);break;end if (v475==(0 -0)) then v476=v68[v79[1793 -((1300 -727) + 1217) ]];v477=nil;v475=2 -1 ;end end elseif (v79[1 + 1 ]<v77[v79[1 + 3 ]]) then v71=v71 + (1 -0) ;else v71=v79[942 -(714 + (1468 -(157 + 1086))) ];end elseif ((v80<=(75 -49)) or (2371>2654)) then if (v80<=21) then if ((v80<=(25 -6)) or (3466>4520)) then if (v80==(2 + 16)) then local v211=v79[2 -0 ];local v212={v77[v211](v13(v77,v211 + (49 -(25 + 23)) ,v72))};local v213=0 + 0 ;for v445=v211,v79[1890 -(927 + 959) ] do local v446=0 -0 ;while true do if ((732 -(16 + 716))==v446) then v213=v213 + 1 ;v77[v445]=v212[v213];break;end end end else local v214;v77[v79[3 -1 ]]=v79[100 -(11 + 86) ];v71=v71 + (2 -1) ;v79=v67[v71];v77[v79[(573 -286) -(175 + 110) ]]=v79[6 -3 ];v71=v71 + 1 ;v79=v67[v71];v214=v79[9 -7 ];v77[v214](v13(v77,v214 + ((7870 -6073) -(503 + (1982 -689))) ,v79[8 -5 ]));v71=v71 + 1 ;v79=v67[v71];v77[v79[2 + 0 ]]=v79[3];v71=v71 + (1062 -(810 + 251)) ;v79=v67[v71];v71=v79[(3 -0) + 0 ];end elseif (v80==(7 + 13)) then local v224=0;local v225;while true do if ((v224==(0 + (819 -(599 + 220)))) or (951>=1027)) then v225=v79[535 -(43 + 490) ];do return v13(v77,v225,v225 + v79[736 -(711 + 22) ] );end break;end end else local v226;v77[v79[7 -(9 -4) ]]=v79[862 -(240 + 619) ];v71=v71 + (1932 -(1813 + 118)) + 0 ;v79=v67[v71];v77[v79[2 -0 ]]=v79[1 + 2 ];v71=v71 + (1745 -(1344 + 293 + 107)) ;v79=v67[v71];v226=v79[407 -(255 + 150) ];v77[v226](v13(v77,v226 + 1 + (1217 -(841 + 376)) ,v79[3]));v71=v71 + 1 + 0 ;v79=v67[v71];v77[v79[8 -6 ]]=v60[v79[3]];v71=v71 + ((3 -0) -2) ;v79=v67[v71];v77[v79[1741 -(404 + 1335) ]]=v79[409 -(183 + 223) ];v71=v71 + (1 -0) ;v79=v67[v71];v226=v79[2 + 0 ];v77[v226](v77[v226 + 1 + 0 ]);v71=v71 + 1 + 0 ;v79=v67[v71];v77[v79[339 -(10 + (892 -565)) ]]=v79[3 + 0 ];v71=v71 + (339 -(118 + 220)) ;v79=v67[v71];v71=v79[3];end elseif ((v80<=(8 + 15)) or (1369>2250)) then if ((v80>(471 -(108 + (1200 -(464 + 395))))) or (937>3786)) then local v241=0;local v242;local v243;while true do if (v241==(2 + 1)) then v77[v79[8 -6 ]]=v79[3];v71=v71 + (1494 -((1824 -1113) + 376 + 406)) ;v79=v67[v71];v243=v79[3 -1 ];v77[v243]=v77[v243](v13(v77,v243 + (470 -(270 + 199)) ,v79[3]));v71=v71 + 1 + 0 ;v241=1823 -(580 + 1239) ;end if (v241==(0 -0)) then v242=nil;v243=nil;v243=v79[2 + 0 ];v77[v243]=v77[v243]();v71=v71 + (838 -(467 + 370)) + 0 ;v79=v67[v71];v241=1 + 0 ;end if (v241==(9 -5)) then v79=v67[v71];v77[v79[2 + 0 ]]=v77[v79[3]][v79[(2419 -1248) -(645 + 522) ]];v71=v71 + 1 ;v79=v67[v71];v77[v79[1792 -(1010 + 780) ]]=v77[v79[3 + 0 ]][v79[19 -15 ]];v71=v71 + 1 + 0 ;v241=14 -9 ;end if (v241==(1837 -(1045 + 791))) then v77[v79[4 -2 ]][v79[4 -1 ]]=v79[509 -(351 + 154) ];v71=v71 + (1575 -(1281 + 293)) ;v79=v67[v71];v77[v79[2]]=v61[v79[269 -(28 + 238) ]];v71=v71 + (2 -1) ;v79=v67[v71];v241=1561 -(1381 + 178) ;end if (v241==((6 -4) + 0)) then v243=v79[2 + 0 ];v242=v77[v79[3]];v77[v243 + 1 + 0 ]=v242;v77
