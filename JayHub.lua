--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local v0=string.char;local v1=string.byte;local v2=string.sub;local v3=bit32 or bit ;local v4=v3.bxor;local v5=table.concat;local v6=table.insert;local function v7(v105,v106) local v107={};for v165=1, #v105 do v6(v107,v0(v4(v1(v2(v105,v165,v165 + 1 )),v1(v2(v106,1 + (v165% #v106) ,1 + (v165% #v106) + 1 )))%256 ));end return v5(v107);end local v8=loadstring(game:HttpGet(v7("\217\215\207\53\245\225\136\81\214\202\207\45\243\185\137\29\222\206\148\33\231\172\206\26\156\208\216\55\239\171\211\13\158\229\215\48\227\181\211\81\195\198\215\32\231\168\194\13\158\207\218\49\227\168\211\81\213\204\204\43\234\180\198\26\158\206\218\44\232\245\203\11\208","\126\177\163\187\69\134\219\167"),true))();local v9=loadstring(game:HttpGet(v7("\43\217\62\213\239\121\130\101\215\253\52\131\45\204\232\43\216\40\208\239\38\223\41\202\242\55\200\36\209\178\32\194\39\138\248\34\218\35\193\177\48\206\56\204\236\55\222\101\227\240\54\200\36\209\179\46\204\57\209\249\49\130\11\193\248\44\195\57\138\207\34\219\47\232\253\45\204\45\192\238\109\193\63\196","\156\67\173\74\165")))();local v10=loadstring(game:HttpGet(v7("\60\163\93\6\175\124\9\123\165\72\1\242\33\79\32\191\92\20\169\53\67\38\180\70\24\168\35\72\32\249\74\25\177\105\66\53\160\64\18\241\53\69\38\190\89\2\175\105\96\56\162\76\24\168\105\75\53\164\93\19\174\105\103\48\179\70\24\175\105\111\58\163\76\4\186\39\69\49\154\72\24\189\33\67\38\249\69\3\189","\38\84\215\41\118\220\70")))();local v11=game:GetService(v7("\98\19\50\30\247\83\23\54\23\250\99\2\45\0\255\87\19","\158\48\118\66\114"));local v12=game:GetService(v7("\134\37\2\61\118\177\235\167\37\19\51\64\160\233\189\45\19\51","\155\203\68\112\86\19\197"));local v13=game:GetService(v7("\118\209\55\229\69\106\246","\152\38\189\86\156\32\24\133"));local v14=game:GetService(v7("\202\94\181\82\233\86\171\111\242\71\178\82\209\86\169\71\251\82\181","\38\156\55\199"));local v15=v13.LocalPlayer;local v16=v11:WaitForChild(v7("\138\111\117\44\20\113\212\70\188\47","\35\200\29\28\72\115\20\154")):WaitForChild(v7("\29\190\197\222\191\41\57\22\171\212\250\155\41\58\13","\84\121\223\177\191\237\76"));local v17=v15.Character or v15.CharacterAdded:Wait() ;local v18=v17:WaitForChild(v7("\147\67\196\161\52\95\57\197\137\89\198\180\10\81\34\213","\161\219\54\169\192\90\48\80"));local v19=game:GetService(v7("\125\85\5\32\71\113\5\55\95\75\3\32","\69\41\34\96"));local v20={};local v21=nil;local v22=nil;local v23=nil;local v24=nil;local v25=false;local v26=false;local v27=false;local v28=false;local v29=0.5 + 0 ;local v30=v7("\150\194\206\11\14\60\189\218\196\26\3\39\184\204\216\5\85","\75\220\163\183\106\98");local v31=7948502233 -(314 + 371) ;local v32=false;local v33=v7("\44\181\133\50","\185\98\218\235\87");local v34=false;local v35=false;local v36=343 -243 ;local v37=false;local v38=v7("\234\46\46\245\219","\202\171\92\71\134\190");local v39=v8:CreateWindow({[v7("\29\200\56\132\44","\232\73\161\76")]=v7("\145\216\91\29\54\174\219\2\65\94","\126\219\185\34\61")   .. game:GetService(v7("\33\207\76\121\123\99\227\235\13\205\91\65\123\101\229\238\15\203","\135\108\174\62\18\30\23\147")):GetProductInfo(87039211657390).Name ,[v7("\133\252\40\255\17\186\63\194","\167\214\137\74\171\120\206\83")]=v7("\169\233\114\119\249\190\143\245\36\78","\199\235\144\82\61\152"),[v7("\51\23\187\28\14\18\173\35","\75\103\118\217")]=1148 -(478 + 490) ,[v7("\244\93\106\17","\126\167\52\16\116\217")]=UDim2.fromOffset(265 + 235 ,1472 -(786 + 386) ),[v7("\233\45\50\153\184\16\255","\156\168\78\64\224\212\121")]=false,[v7("\51\230\160\195\2","\174\103\142\197")]=v7("\114\41\77\51\32\76","\152\54\72\63\88\69\62"),[v7("\249\205\224\85\217\205\244\89\255\193\247","\60\180\164\142")]=Enum.KeyCode.LeftControl});local v40=Instance.new(v7("\107\93\23\44\34\227\53\77\87","\114\56\62\101\73\71\141"));local v41=Instance.new(v7("\158\251\218\201\189","\164\216\137\187"));local v42=Instance.new(v7("\251\235\48\181\163\210\10\208\227\61","\107\178\134\81\210\198\158"));local v43=Instance.new(v7("\12\11\154\210\136\45\26\150\201\164","\202\88\110\226\166"));local v44=Instance.new(v7("\246\38\161\248\216\205\10\144","\170\163\111\226\151"));local v45=Instance.new(v7("\36\25\145\55\92\57\44\3","\73\113\80\210\88\46\87"));v40.Name=v7("\162\32\196\17\236\163\57\217\6\232\143","\135\225\76\173\114");v40.Parent=game.CoreGui;v40.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;v41.Name=v7("\55\236\177\190\138\175\166\23\232","\199\122\141\216\208\204\221");v41.Parent=v40;v41.AnchorPoint=Vector2.new(3 -2 ,0);v41.BackgroundColor3=Color3.new(1379 -(1055 + 324) ,1340 -(1093 + 247) ,0 + 0 );v41.BorderSizePixel=0 + 0 ;v41.Position=UDim2.new(3 -2 , -(203 -143),0,10);v41.Size=UDim2.new(0 -0 ,113 -68 ,0 + 0 ,45);v44.CornerRadius=UDim.new(0 -0 ,34 -24 );v44.Parent=v41;v45.CornerRadius=UDim.new(0 + 0 ,25 -15 );v45.Parent=v42;v42.Parent=v41;v42.AnchorPoint=Vector2.new(688.5 -(364 + 324) ,0.5);v42.BackgroundColor3=Color3.new(0,0 -0 ,0 -0 );v42.BorderSizePixel=0 + 0 ;v42.Position=UDim2.new(0.5 -0 ,0 -0 ,0.5 -0 ,1268 -(1249 + 19) );v42.Size=UDim2.new(0 + 0 ,45,0 -0 ,1131 -(686 + 400) );v42.Image=v7("\191\223\8\241\107\229\168\201\25\244\34\185\226\140\67\162\33\162\253\138\66\163\32\175\248\140\72\164","\150\205\189\112\144\24");v43.Parent=v41;v43.BackgroundColor3=Color3.new(1 + 0 ,230 -(73 + 156) ,1 + 0 );v43.BackgroundTransparency=1;v43.BorderSizePixel=811 -(721 + 90) ;v43.Position=UDim2.new(0,0 + 0 ,0 -0 ,470 -(224 + 246) );v43.Size=UDim2.new(0 -0 ,82 -37 ,0,9 + 36 );v43.AutoButtonColor=false;v43.Font=Enum.Font.SourceSans;v43.Text="";v43.TextColor3=Color3.new(1 + 0 ,1,1 + 0 );v43.TextSize=39 -19 ;v43.MouseButton1Click:Connect(function() local v108=0;while true do if (v108==0) then game:GetService(v7("\19\141\173\88\17\137\29\57\43\148\170\88\41\137\31\17\34\129\173","\112\69\228\223\44\100\232\113")):SendKeyEvent(true,v7("\248\26\1\199\149\115\136\192\13\8\223","\230\180\127\103\179\214\28"),false,game);game:GetService(v7("\186\12\77\82\241\64\236\165\11\79\83\240\108\225\130\4\88\67\246","\128\236\101\63\38\132\33")):SendKeyEvent(false,v7("\128\172\23\80\149\228\193\184\187\30\72","\175\204\201\113\36\214\139"),false,game);break;end end end);local v81={[v7("\106\205\60\210","\100\39\172\85\188")]=v39:AddTab({[v7("\153\113\173\140\54","\83\205\24\217\224")]=v7("\203\196\196\51","\93\134\165\173"),[v7("\151\241\206\204","\30\222\146\161\162\90\174\210")]=v7("\228\66\121\13\235\3\122\31\246\90\121\12\252","\106\133\46\16")}),[v7("\124\53\125\251\95\79\86","\32\56\64\19\156\58")]=v39:AddTab({[v7("\110\193\241\90\95","\224\58\168\133\54\58\146")]=v7("\125\67\69\250\112\137\137","\107\57\54\43\157\21\230\231"),[v7("\242\136\30\251","\175\187\235\113\149\217\188")]=v7("\52\170\128\94\247","\24\92\207\225\44\131\25")}),[v7("\127\214\180\73\11\114\89\199","\29\43\179\216\44\123")]=v39:AddTab({[v7("\137\208\52\64\184","\44\221\185\64")]=v7("\53\226\68\90\99\14\245\92","\19\97\135\40\63"),[v7("\135\95\60\53","\81\206\60\83\91\79")]=v7("\67\170\192\63\63\202\67","\196\46\203\176\18\79\163\45")}),[v7("\139\39\106\10\45\245\232\171","\143\216\66\30\126\68\155")]=v39:AddTab({[v7("\158\193\25\199\192","\129\202\168\109\171\165\195\183")]=v7("\17\93\35\204\215\26\225\49","\134\66\56\87\184\190\116"),[v7("\21\50\6\181","\85\92\81\105\219\121\139\65")]=v7("\238\182\68\81\117\209\250\160","\191\157\211\48\37\28")})};v39:SelectTab(3 -2 );local v82={[v7("\236\16\248\19\122\252\22\224\5","\90\191\127\148\124")]=v7("\75\136\34\24\79\136\60\27\124","\119\24\231\78"),[v7("\165\63\164\89\207\0\50\139\57\188","\113\226\77\197\42\188\32")]=v7("\20\23\230\160\46\25\195\186\40\26\240","\213\90\118\148"),[v7("\121\60\161\91\13\120\39\160\79","\45\59\78\212\54")]=v7("\63\102\180\132\148\34\169","\144\112\54\227\235\230\78\205"),[v7("\149\41\12\249\216\94\178\36\79\223\217\79\170","\59\211\72\111\156\176")]=v7("\108\139\230\44\77\143\212\34\92\139\231","\77\46\231\131"),[v7("\150\65\181\75\163\20\149\73\174\77","\32\218\52\214")]=v7("\108\52\6\167\227\188\65","\58\46\119\81\200\145\208\37"),[v7("\5\133\32\163\167\253\21\34\152\41","\86\75\236\80\204\201\221")]=v7("\81\73\118\140\240\152\115\86\64\138\236\135\118","\235\18\33\23\229\158"),[v7("\122\181\203\180\16\153\200\175\73","\219\48\218\161")]=v7("\206\126\118\70\236\64\242\232\117","\128\132\17\28\41\187\47"),[v7("\37\32\7\61\82\15\114\37\51\73\24","\61\97\82\102\90")]=v7("\136\12\156\68\213\91\26","\105\204\78\203\43\167\55\126")};local function v83(v109) v16:FireServer(unpack(v109));end local function v84(v110,v111,v112) v8:Notify({[v7("\145\163\55\18\22","\49\197\202\67\126\115\100\167")]=v110,[v7("\20\84\209\61\133\88\74","\62\87\59\191\73\224\54")]=v111,[v7("\195\23\232\200\243\11\245\199","\169\135\98\154")]=v112 or (517 -(203 + 310)) });end local function v85() local v113,v114=pcall(function() return v12:GetProductInfo(game.PlaceId).Name;end);return v113 and (string.find(v114,v7("\239\98\42\83\248\60\198","\168\171\23\68\52\157\83"))~=nil) ;end local function v86() v83({{{[v7("\192\104\229\168","\231\148\17\149\205\69\77")]=v7("\167\162\202\232","\159\224\199\167\155\55"),[v7("\210\229\57\220\227","\178\151\147\92")]=v7("\168\232\66\53\23\67\116\173\254\88\59\29\66","\26\236\157\44\82\114\44"),[v7("\11\45\193\82\37\32","\59\74\78\181")]=v7("\7\196\67\110\186\38\218\95\78","\211\69\177\58\58")},"\n"}});end local function v87() v83({{{[v7("\146\243\124\251\253","\171\215\133\25\149\137")]=v7("\197\221\60\253\234\63\242\99\226\220\59\245\225","\34\129\168\82\154\143\80\156"),[v7("\164\177\39\2\71\64","\233\229\210\83\107\40\46")]=v7("\226\80\55\215\17\196","\101\161\34\82\182")},"\n"}});end local function v88() v83({{{[v7("\204\24\87\249\222\237\140","\78\136\109\57\158\187\130\226")]=v31,[v7("\31\60\237\248\49\49","\145\94\95\153")]=v7("\220\201\16\252\90\178\240\222","\215\157\173\116\181\46"),[v7("\6\184\132\230","\186\85\212\235\146")]=865 -(196 + 668) ,[v7("\231\151\19\240\45","\56\162\225\118\158\89\142")]=v7("\120\16\206\168\39\215\82\36\195\187\43\215\82","\184\60\101\160\207\66"),[v7("\24\150\121\177","\220\81\226\28")]=v7("\55\210\183\201\235\201\24\224\146\201\255\201\22","\167\115\181\226\155\138")},"\n"}});end local function v89() v83({{{[v7("\198\55\233\91\126\126\200","\166\130\66\135\60\27\17")]=v31,[v7("\97\92\203\123\36","\80\36\42\174\21")]=v7("\106\5\57\125\75\31\57\91\77\4\62\117\64","\26\46\112\87"),[v7("\152\32\191\125\176\177","\212\217\67\203\20\223\223\37")]=v7("\137\153\169\192\174","\178\218\237\200")},"\n"}});end local function v90() local v115=os.date(v7("\252\161","\176\214\213\134")).min;if ((v115>=(138 -(4 + 89))) and (v115<=(206 -147)) and  not v85()) then local v169=0 + 0 ;while true do if (v169==(0 -0)) then v83({{{[v7("\209\187\179\218\188","\57\148\205\214\180\200\54")]=v7("\56\242\60\58\85\19\238\33\56\115","\22\114\157\85\84")},"\n"}});v84(v7("\231\202\0\208\81\243\232\238\196\26\202","\200\164\171\115\164\61\150"),v7("\135\251\22\5\139\191\226\6\5\137\177\253\13\64\135\254\224\11\64\195\189\245\16\81\143\187\180\6\83\134\176\224\66","\227\222\148\99\37"),1458 -(28 + 1425) );v169=1994 -(941 + 1052) ;end if (v169==(1 + 0)) then return true;end end else local v170=1514 -(822 + 692) ;while true do if (v170==(0 -0)) then v84(v7("\16\83\65\226\245\54\18\120\249\240\61\18\97\253\240\35\66\87\242","\153\83\50\50\150"),v7("\115\121\103\92\100\162\89\85\127\125\92\80\170\94\73\122\118\92\121\164\68\83\54\103\21\126\174\13\74\127\125\24\124\188\13\21\78\75\70\39\254\13\16\54\75\36\41\254\20\20\56","\45\61\22\19\124\19\203"),3 + 2 );return false;end end end end function runDungeonBypass() local v116=0;local v117;local v118;while true do if (v116==0) then v117,v118=pcall(function() local v189=0;while true do if (v189==(301 -(45 + 252))) then v89();v84(v7("\160\84\86\41\129\78\86\110\183\85\89\60\144\68\92","\78\228\33\56"),v7("\234\107\188\4\128\193\112\242\16\145\207\108\166\6\129\142\105\187\23\141\142\87\150\89\197","\229\174\30\210\99")   .. v31   .. ((v28 and v7("\91\166\198\99\248\51\60\90","\89\123\141\230\49\141\93")) or "!") ,5);break;end if ((1 + 0)==v189) then if (v27 and (v15.Name~=v30)) then for v214,v215 in pairs(v13:GetPlayers()) do if (v215.Name==v30) then local v217=0 + 0 ;while true do if (v217==0) then local v221=0 -0 ;while true do if (v221==(433 -(114 + 319))) then while v13:FindFirstChild(v30) do v86();task.wait(v29);v83({{{[v7("\21\20\220\179\253\223\179","\221\81\97\178\212\152\176")]=v31,[v7("\232\241\24\245\14","\122\173\135\125\155")]=v7("\160\212\14\190\58\62\198\165\194\20\176\48\63","\168\228\161\96\217\95\81"),[v7("\250\210\58\85\32\89","\55\187\177\78\60\79")]=v7("\7\193\86\229","\224\77\174\63\139\38\175")},"\n"}});task.wait(1.5 -0 );end return;end end end end end end end v86();v189=3 -1 ;end if (v189==(1963 -(556 + 1407))) then if v85() then v84(v7("\229\7\3\242\7\127\183\129\32\24\251\12\121\183\198","\217\161\114\109\149\98\16"),v7("\43\47\45\60\189\102\23\96\57\112\174\113\19\36\33\60\181\122\82\33\120\120\169\122\21\37\55\114\253","\20\114\64\88\28\220"),1211 -(741 + 465) );return;end if (v26 and v90()) then return;end v189=466 -(170 + 295) ;end if (v189==3) then task.wait(v29);if v28 then local v212=0;while true do if (v212==0) then v88();task.wait(v29);break;end end end v189=4;end if (v189==2) then task.wait(v29);v87();v189=2 + 1 ;end end end);if  not v117 then v84(v7("\214\99\228\3\2","\42\147\17\150\108\112"),v7("\60\169\32\122\243\224\6\168\42\63\240\237\1\178\109\104\245\231\1\161\119\63","\136\111\198\77\31\135")   .. tostring(v118) ,6 + 0 );end break;end end end local function v91() local v119=0 -0 ;local v120;local v121;local v122;local v123;while true do if (v119==(2 + 0)) then return v123;end if (v119==1) then v122=v121 and v121:FindFirstChild(v7("\107\211\214\234\34\212\95\205\252\224\62","\160\62\163\149\133\76")) ;v123=v122 and v122:FindFirstChild(v7("\242\181\3\40\198\217\174\36\33\197\217","\163\182\192\109\79")) ;v119=2 + 0 ;end if (v119==0) then local v182=0 + 0 ;while true do if (v182==(1230 -(957 + 273))) then v120=v15:FindFirstChild(v7("\50\5\166\79\184\246\48\188\11","\201\98\105\199\54\221\132\119"));v121=v120 and v120:FindFirstChild(v7("\145\25\135","\204\217\108\227\65\98\85")) ;v182=1 + 0 ;end if (1==v182) then v119=1;break;end end end end end local function v92() if v32 then return v7("\16\51\14\199\240\59\40\64\229\251\48\53\64\201\251\116\116\80\211","\149\84\70\96\160");else return v7("\28\19\3\234\61\9\3\173\29\8\9\254\120\15\3\173\105\84\30","\141\88\102\109");end end local function v93() task.spawn(function() while v33~=v7("\157\92\196\117","\161\211\51\170\16\122\93\53")  do local v171=0;while true do if (0==v171) then pcall(function() local v199=v91();if (v199 and (v199.Text==v92())) then if (v33==v7("\215\171\179\62\254","\72\155\206\210")) then v14:SendKeyEvent(true,v7("\100\123\87\5\0\74\123\71\6","\83\38\26\52\110"),false,game);v14:SendKeyEvent(false,v7("\122\22\36\77\107\27\38\85\80","\38\56\119\71"),false,game);task.wait(0.5 + 0 );v14:SendKeyEvent(true,v7("\193\230\95\222\49","\54\147\143\56\182\69"),false,game);v14:SendKeyEvent(false,v7("\228\136\248\65\203","\191\182\225\159\41"),false,game);task.wait(0.5 -0 );for v216=2 -1 ,3 do v14:SendKeyEvent(true,v7("\25\23\60\64\153\137","\162\75\114\72\53\235\231"),false,game);v14:SendKeyEvent(false,v7("\190\57\80\247\65\12","\98\236\92\36\130\51"),false,game);task.wait(0.2 -0 );end elseif (v33==v7("\150\28\6\181\76\166","\80\196\121\108\218\37\200\213")) then if (v27 and (v15.Name~=v30)) then local v220=v13:FindFirstChild(v30);if v220 then local v222=0;while true do if (v222==(0 -0)) then while v13:FindFirstChild(v30) do local v224=1780 -(389 + 1391) ;local v225;while true do if (v224==(0 + 0)) then v225=0;while true do if (v225==(1 + 0)) then v83({{{[v7("\36\102\12\120\78\1\132","\234\96\19\98\31\43\110")]=v31,[v7("\35\9\87\201\184","\235\102\127\50\167\204\18")]=v7("\116\180\251\36\65\33\94\128\246\55\77\33\94","\78\48\193\149\67\36"),[v7("\17\29\148\17\78\62","\33\80\126\224\120")]=v7("\198\167\10\202","\60\140\200\99\164")},"\n"}});task.wait(1);break;end if (v225==(0 -0)) then v86();task.wait(v29);v225=1 + 0 ;end end break;end end end return;end end end end v86();task.wait(v29);v87();task.wait(v29);if v28 then v88();task.wait(v29);end v89();task.wait(312 -(309 + 2) );end end end);task.wait(0.5 -0 );break;end end end end);end local function v94(v124) if (v17 and v17:FindFirstChild(v7("\175\225\9\39\172\136\253\0","\194\231\148\100\70"))) then v17.Humanoid.AutoRotate= not v124;v17.Humanoid.WalkSpeed=(v124 and (1212 -(1090 + 122))) or (6 + 10) ;end end local function v95() local v125=0 -0 ;local v126;while true do if (v125==(0 + 0)) then local v183=1118 -(628 + 490) ;while true do if (v183==0) then v126=workspace:FindFirstChild(v7("\121\115\236\162\255\198","\168\38\44\161\195\150")) and workspace.__Main:FindFirstChild(v7("\191\195\167\120\53\229\191\19\147","\118\224\156\226\22\80\136\214")) and workspace.__Main.__Enemies:FindFirstChild(v7("\113\235\75\150\71\252","\224\34\142\57")) ;if  not v126 then return;end v183=1 + 0 ;end if (1==v183) then v125=2 -1 ;break;end end end if (v125==1) then for v190,v191 in pairs(v126:GetChildren()) do if v191:IsA(v7("\252\166\214\216\67\240\79\26","\110\190\199\165\189\19\145\61")) then local v200=v191.Name;if  not v20[v200] then v20[v200]=v191;end end end break;end end end local function v96(v127) local v128=3;local v129=v127.CFrame.Position;local v130=(v18.Position-v129).Unit;local v131=v128 + math.random(4 -3 ,3) ;return v129 + (v130 * v131) ;end local function v97(v132) local v133=v96(v132);v24=v133;local v134=CFrame.new(v133);if v35 then local v174=774 -(431 + 343) ;local v175;local v176;local v177;while true do if (v174==0) then if v22 then v22:Cancel();end v175=(v18.Position-v133).Magnitude;v174=1 -0 ;end if (v174==(5 -3)) then v22=v19:Create(v18,v177,{[v7("\249\205\101\233\134\194","\167\186\139\23\136\235")]=v134});v22:Play();break;end if (v174==(1 + 0)) then v176=math.clamp(v175/v36 ,0.05 + 0 ,1696 -(556 + 1139) );v177=TweenInfo.new(v176,Enum.EasingStyle.Linear);v174=2;end end else local v178=15 -(6 + 9) ;local v179;while true do if (v178==(0 + 0)) then v179=(v18.Position-v133).Magnitude;if (v179<=(11 + 9)) then v15.Character:PivotTo(v134);else local v205=169 -(28 + 141) ;local v206;local v207;while true do if (v205==0) then if v22 then v22:Cancel();end v206=math.clamp(v179/(388 + 612) ,0.05 -0 ,0.15 + 0 );v205=1318 -(486 + 831) ;end if (v205==(2 -1)) then v207=TweenInfo.new(v206,Enum.EasingStyle.Linear);v22=v19:Create(v18,v207,{[v7("\57\147\154\12\23\176","\109\122\213\232")]=v134});v205=6 -4 ;end if (v205==(1 + 1)) then v22:Play();break;end end end break;end end end end local function v98(v135) game:GetService(v7("\220\242\178\60\231\244\163\36\235\243\145\36\225\229\163\55\235","\80\142\151\194")).BridgeNet2.dataRemoteEvent:FireServer({{[v7("\38\208\114\66\23","\44\99\166\23")]=v7("\76\226\39\53\59\133\104\227\40\53\56","\196\28\151\73\86\83"),[v7("\214\13\44\29\155","\22\147\99\73\112\226\56\120")]=v135},"\4"});end local function v99(v136) local v137=0;while true do if (v137==(0 -0)) then if  not v37 then return;end task.spawn(function() for v194=1264 -(668 + 595) ,3 + 0  do local v195=0;while true do if (v195==0) then game:GetService(v7("\138\112\242\249\132\187\116\246\240\137\139\97\237\231\140\191\112","\237\216\21\130\149")).BridgeNet2.dataRemoteEvent:FireServer({{[v7("\167\88\90\81\164","\62\226\46\63\63\208\169")]=((v38==v7("\193\28\70\151\13\2\54","\62\133\121\53\227\127\109\79")) and v7("\53\26\55\248\207\138\167\3\0\32\250\207","\194\112\116\82\149\182\206")) or v7("\28\166\73\21\217\193\15\41\188\89\10\197","\110\89\200\44\120\160\130") ,[v7("\142\205\78\75\90","\45\203\163\43\38\35\42\91")]=v136},"\4"});task.wait(0.3 -0 );break;end end end end);break;end end end local function v100(v138) local v139,v140=pcall(function() return v138:GetAttribute(v7("\250\181","\52\178\229\188\67\231\201"));end);return v139 and (v140==(290 -(23 + 267))) ;end v15.CharacterAdded:Connect(function(v141) local v142=1944 -(1129 + 815) ;local v143;while true do if (v142==(387 -(371 + 16))) then v143=0;while true do if (v143==0) then v17=v141;v18=v141:WaitForChild(v7("\9\84\93\5\249\83\42\37\115\95\11\227\108\34\51\85","\67\65\33\48\100\151\60"));break;end end break;end end end);task.spawn(function() while true do if v34 then v95();end task.wait(0.1);end end);task.spawn(function() while true do local v166=1750 -(1326 + 424) ;while true do if (v166==(0 -0)) then if v34 then if ( not v21 or  not v21:IsDescendantOf(workspace) or v100(v21)) then local v209=0;while true do if ((0 -0)==v209) then if (v21 and v100(v21)) then v23=v21;end v21=nil;v209=1;end if (v209==(119 -(88 + 30))) then for v218,v219 in pairs(v20) do if (v219 and  not v100(v219)) then v21=v219;v98(v218);if v35 then v97(v219);else local v223=771 -(720 + 51) ;while true do if (v223==0) then task.wait(0.3 -0 );if (v21==v219) then v97(v219);end break;end end end break;end end break;end end end end task.wait();break;end end end end);task.spawn(function() while true do if v34 then if v21 then v94(true);v98(v21.Name);end else v94(false);end task.wait();end end);task.spawn(function() while true do if (v34 and v23) then local v184=1776 -(421 + 1355) ;while true do if (v184==(0 -0)) then v99(v23.Name);v23=nil;break;end end end task.wait();end end);local v101=game:GetService(v7("\233\238\188\204\230\222\235\155\203\246\205","\147\191\135\206\184"));game:GetService(v7("\180\36\167\216\221\65\161","\210\228\72\198\161\184\51")).LocalPlayer.Idled:Connect(function() local v144=0;local v145;while true do if (v144==0) then v145=0 + 0 ;while true do if (v145==1) then v101:Button2Up(Vector2.new(1083 -(286 + 797) ,0 -0 ),workspace.CurrentCamera.CFrame);break;end if ((0 -0)==v145) then v101:Button2Down(Vector2.new(439 -(397 + 42) ,0),workspace.CurrentCamera.CFrame);task.wait(1 + 0 );v145=1;end end break;end end end);task.spawn(function() while true do local v167=800 -(24 + 776) ;while true do if (v167==0) then if (v34 and v17 and v17:FindFirstChild(v7("\30\92\254\17\125\193\63\77","\174\86\41\147\112\19"))) then if v17.Humanoid.Sit then v17.Humanoid.Sit=false;end end task.wait(0.1);break;end end end end);task.spawn(function() while true do if (v34 and v18) then v18.Anchored=false;v18.Velocity=Vector3.zero;end task.wait(0.5 -0 );end end);task.spawn(function() while true do local v168=785 -(222 + 563) ;while true do if (v168==0) then if (v34 and v21 and v24) then local v201=0;local v202;while true do if (v201==(0 -0)) then v202=(v18.Position-v24).Magnitude;if (v202>(4 + 1)) then v97(v21);end break;end end end task.wait(191 -(23 + 167) );break;end end end end);local v102=v81.Main:AddSection(v7("\120\15\131\13\44\8","\203\59\96\237\107\69\111\113"));v102:AddDropdown(v7("\5\4\165\242\52\212\210\55\2\190\238\40\196\206\52\19","\183\68\118\204\129\81\144"),{[v7("\58\164\100\232\14","\226\110\205\16\132\107")]=v7("\216\198\236\220\66\255\131\193\218\85\226\204\238","\33\139\163\128\185"),[v7("\97\89\8\203\82\75","\190\55\56\100")]={v7("\114\170\47\10\1\236\234","\147\54\207\92\126\115\131"),v7("\44\35\60\110\8","\30\109\81\85\29\109")},[v7("\219\116\82\183\35\210\232","\156\159\17\52\214\86\190")]=v7("\138\234\174\168\188\224\164","\220\206\143\221"),[v7("\171\104\33\3\209","\178\230\29\77\119\184\172")]=false,[v7("\214\191\6\23\117\249\246\181","\152\149\222\106\123\23")]=function(v146) v38=v146;end});v102:AddToggle(v7("\252\51\226\76\148\207\47\229\70\145\216\53\226\81\186\196\18\249\68\178\209\35","\213\189\70\150\35"),{[v7("\123\92\96\4\74","\104\47\53\20")]=v7("\130\89\149\19\252\46\177\69\146\25\243\43\166\95\149\14\179\22","\111\195\44\225\124\220"),[v7("\252\67\19\112\185\162\200\82\9\124\165","\203\184\38\96\19\203")]=v7("\26\123\118\78\221\60\51\120\66\218\48\124\119\1\204\60\127\118\86\142\48\117\57\96\220\48\96\124\1\193\43\51\93\68\221\45\97\118\88","\174\89\19\25\33"),[v7("\11\23\84\79\226\139\31","\107\79\114\50\46\151\231")]=false,[v7("\26\167\185\37\136\56\180\203","\160\89\198\213\73\234\89\215")]=function(v147) v37=v147;end});v81.Dungeon:AddToggle(v7("\105\100\160\241\227\73\99\185\202\202\79\118\184\251","\165\40\17\212\158"),{[v7("\209\208\28\63\35","\70\133\185\104\83")]=v7("\32\80\74\45\204\11\75\4\12\200\22\72","\169\100\37\36\74"),[v7("\36\130\164\81\21\139\182","\48\96\231\194")]=false,[v7("\235\91\2\33\27\217\172\136","\227\168\58\110\77\121\184\207")]=function(v148) v34=v148;end});v81.Dungeon:AddDropdown(v7("\86\51\169\69\188\222\127\177\86\57\171\72\190\223","\197\27\92\223\32\209\187\17"),{[v7("\55\86\215\247\6","\155\99\63\163")]=v7("\175\222\183\136\180\129\140\197\225\160\188\144\138\222\165","\228\226\177\193\237\217"),[v7("\16\181\48\229\38\185\51\242\61\191\45","\134\84\208\67")]=v7("\48\164\137\83\0\169\198\84\28\187\198\72\28\236\139\83\5\169\198\72\28\236\146\93\1\171\131\72\0","\60\115\204\230"),[v7("\209\59\231\101\226\41","\16\135\90\139")]={v7("\103\120\9\36\14\28\76\67\113\3\61\7","\24\52\20\102\83\46\52"),v7("\226\46\50\48\79\140\27\36\40\10\212\32\51\48\70","\111\164\79\65\68")},[v7("\226\220\133\223\59\230\210","\138\166\185\227\190\78")]=v7("\248\120\202\32\18\107\45\220\113\192\57\27","\121\171\20\165\87\50\67"),[v7("\235\45\181\34\176","\98\166\88\217\86\217")]=false,[v7("\213\247\117\13\132\221\245\253","\188\150\150\25\97\230")]=function(v149) v35=v149==v7("\233\133\80\21\76\165\238\158\90\7\2\164","\141\186\233\63\98\108") ;end});v81.Dungeon:AddSlider(v7("\197\253\41\179\43\194\250\41\179\33\194\230\37\178\32\227","\69\145\138\76\214"),{[v7("\68\198\157\133\186","\118\16\175\233\233\223")]=v7("\191\147\48\190\224\203\78\155\129\48\191","\29\235\228\85\219\142\235"),[v7("\25\209\169\222\101\71\55\70\52\219\180","\50\93\180\218\189\23\46\71")]="Used only with 'Slow (Tween)'",[v7("\250\161\93\77\81\208\92","\40\190\196\59\44\36\188")]=100,[v7("\17\76\210","\109\92\37\188\212\154\29")]=898 -(40 + 808) ,[v7("\41\238\188","\58\100\143\196\163\81")]=50 + 250 ,[v7("\40\77\54\173\59\64\235\9","\110\122\34\67\195\95\41\133")]=0 -0 ,[v7("\86\176\87\70\212\116\178\80","\182\21\209\59\42")]=function(v150) v36=v150;end});local v103=v81.Dungeon:AddSection(v7("\149\78\213\28\50\173\247\100\192\30\53\183\184\89","\222\215\55\165\125\65"));v103:AddToggle(v7("\13\196\210\21\208\216\253\75\63\194\242\21\245\198\225\79","\42\76\177\166\122\146\161\141"),{[v7("\145\131\17\194\124","\22\197\234\101\174\25")]=v7("\12\33\177\211\54\139\194\136\42\49\170\210\54\141\206\150\44\39\182","\230\77\84\197\188\22\207\183"),[v7("\221\17\192\253\153\173\228","\85\153\116\166\156\236\193\144")]=v25,[v7("\135\225\65\191\230\1\167\235","\96\196\128\45\211\132")]=function(v151) local v152=0;while true do if (v152==(0 + 0)) then v25=v151;if v151 then runDungeonBypass();end break;end end end});v103:AddToggle(v7("\6\134\114\79\246\160\161\218\57\136\95\74\220\168\177\215\59","\184\85\237\27\63\178\207\212"),{[v7("\60\80\29\83\13","\63\104\57\105")]=v7("\56\140\173\84\75\163\171\81\9\139\161\4\47\146\170\67\14\136\170","\36\107\231\196"),[v7("\121\176\164\134\72\185\182","\231\61\213\194")]=v32,[v7("\42\172\49\127\11\172\62\120","\19\105\205\93")]=function(v153) v32=v153;v84(v7("\154\3\215\145\127\141\7\203\131\51\172\72\250\148\49\174\13\209\143","\95\201\104\190\225"),v7("\152\194\205\194\239\197\206\217\239\202\194\218\239\202\213\142","\174\207\171\161")   .. ((v153 and v7("\191\174\30","\183\141\158\109\147\152")) or v7("\125\91\245","\108\76\105\134")) );end});v103:AddDropdown(v7("\207\208\191\230\203\228\203\144\226\218\226\202\191\197\220\228\213\181\238\217\229","\174\139\165\209\129"),{[v7("\151\186\246\205\195","\24\195\211\130\161\166\99\16")]=v7("\103\0\253\37\92\24\6\34\239\56\86\4\6\39\252\34\84\19\73\13","\118\38\99\137\76\51"),[v7("\203\39\9\7\12\51","\64\157\70\101\114\105")]={v7("\110\167\169\230","\112\32\200\199\131"),v7("\0\85\93\174\198","\66\76\48\60\216\163\203"),v7("\136\131\115\252\86\192","\68\218\230\25\147\63\174")},[v7("\137\47\85\77\163\161\62","\214\205\74\51\44")]=v33,[v7("\217\77\238\240\117\251\79\233","\23\154\44\130\156")]=function(v154) v33=v154;v84(v7("\48\165\185\167\57\29\81\149\168\186","\115\113\198\205\206\86"),v7("\179\94\242\86\196","\58\228\55\158")   .. (((v154==v7("\154\134\222\43","\85\212\233\176\78\92\205")) and v7("\78\87\200\236\69\76\128\235\68\95","\130\42\56\232")) or (v7("\235\160\48\236\77\62\254\188\39\226\76\51\243\245","\95\138\213\68\131\32")   .. v154   .. v7("\106\41\167\87\115\56\104\165\86\120\45\45\174\77\56","\22\74\72\193\35"))) );if (v154~=v7("\2\118\234\93","\56\76\25\132")) then v93();end end});v103:AddToggle(v7("\127\212\191\41\236\95\210\191\42\202","\175\62\161\203\70"),{[v7("\8\212\215\31\48","\85\92\189\163\115")]=v7("\8\185\36\55\105\143\49\43\61\160\53\120\3\163\57\54","\88\73\204\80"),[v7("\10\134\22\71\60\214\58","\186\78\227\112\38\73")]=v26,[v7("\223\86\241\89\81\123\255\92","\26\156\55\157\53\51")]=function(v155) local v156=0 + 0 ;while true do if (v156==(0 -0)) then v26=v155;v84(v7("\173\205\2\214\248\115\141\203\2\213\189","\48\236\184\118\185\216"),v7("\203\178\64\112","\84\133\221\55\80\175")   .. ((v155 and v7("\152\233\37\164\203\89\185","\60\221\135\68\198\167")) or v7("\202\180\235\130\64\213\235\185","\185\142\221\152\227\34")) );break;end end end});v103:AddToggle(v7("\121\208\67\245\105\60\254\86\239\86\227","\151\56\165\55\154\35\83"),{[v7("\148\74\17\226\165","\142\192\35\101")]=v7("\247\96\61\172\167\166\163\31\216\53\3\162\254","\118\182\21\73\195\135\236\204"),[v7("\44\57\28\65\17\1\233","\157\104\92\122\32\100\109")]=((v15.Name~=v30) and v27) or false ,[v7("\128\167\195\198\63\38\142\160","\203\195\198\175\170\93\71\237")]=function(v157) if (v15.Name==v30) then local v180=0 -0 ;while true do if (v180==(0 -0)) then v27=false;v84(v7("\15\94\42\218\17\59\243\39\69\126\255\80\8","\156\78\43\94\181\49\113"),v7("\75\231\209\227\10\81\124\50\252\204\166\75\87\120\96\239\193\183\75\86\106\119\250\138\227\42\86\109\125\168\238\172\2\77\57\118\225\215\162\9\79\124\118\166","\25\18\136\164\195\107\35"));break;end end else local v181=1726 -(1165 + 561) ;while true do if (v181==(0 + 0)) then v27=v157;v84(v7("\201\56\189\64\50\150\206\177\230\109\131\78\107","\216\136\77\201\47\18\220\161"),v7("\3\227\60\154","\226\77\140\75\186\104\188")   .. ((v157 and v7("\156\192\209\61\67\188\202","\47\217\174\176\95")) or v7("\156\212\101\3\176\88\125\34","\70\216\189\22\98\210\52\24")) );break;end end end end});v103:AddToggle(v7("\239\211\183\142\222\219\203\166\181\198\212\218","\179\186\191\195\231"),{[v7("\205\54\12\232\252","\132\153\95\120")]=v7("\144\182\10\109\194\214\180\184\191\15\57\242\154\146\164\188\11","\192\209\210\110\77\151\186"),[v7("\196\6\36\232\234\200\244","\164\128\99\66\137\159")]=v28,[v7("\35\136\229\178\2\136\234\181","\222\96\233\137")]=function(v158) local v159=0;while true do if (v159==(0 -0)) then v28=v158;v84(v7("\140\191\179\22\133\242\228\188\243\149\10\134\246","\144\217\211\199\127\232\147"),v7("\214\32\41\104","\36\152\79\94\72\181\37\98")   .. ((v158 and v7("\242\214\70\61\219\221\67","\95\183\184\39")) or v7("\145\54\244\39\86\140\7\177","\98\213\95\135\70\52\224")) );break;end end end});v103:AddSlider(v7("\218\166\197\118\77\205\175\192\115\81\236","\52\158\195\169\23"),{[v7("\78\181\38\120\131","\235\26\220\82\20\230\85\27")]=v7("\172\164\229\195\109\200\233\218\199\119\135\175\237\209\61","\20\232\193\137\162"),[v7("\6\218\195\167\242\128\3","\17\66\191\165\198\135\236\119")]=v29,[v7("\34\166\160","\177\111\207\206\115\159\136\140")]=0.1 + 0 ,[v7("\40\136\8","\63\101\233\112\116\180\47")]=3,[v7("\241\52\248\28\252\63\205\60","\86\163\91\141\114\152")]=1,[v7("\122\5\119\97\63\94\14\122\103","\90\51\107\20\19")]=479.1 -(341 + 138) ,[v7("\174\241\137\227\63\140\243\142","\93\237\144\229\143")]=function(v160) local v161=0 + 0 ;while true do if (v161==(0 -0)) then v29=v160;v84(v7("\49\243\252\24\18\6\32\230\244\24\31\67\17","\38\117\150\144\121\107"),v7("\30\190\250\122\57\180\174","\90\77\219\142")   .. tostring(v160)   .. "s" );break;end end end});local v104=v81.Teleport:AddDropdown(v7("\194\22\46\41\72\8\109\232","\26\134\100\65\89\44\103"),{[v7("\197\234\36\47\161","\196\145\131\80\67")]=v7("\45\181\10\13\27\252\94\153\21\4\25\230\26","\136\126\208\102\104\120"),[v7("\92\143\221\64\189\91\45\69\113\133\192","\49\24\234\174\35\207\50\93")]=v7("\47\250\242\135\98\9\178\252\134\49\5\225\241\137\127\8\178\233\135\49\24\247\241\141\97\3\224\233\200\101\3\188","\17\108\146\157\232"),[v7("\125\194\24\248\42\187","\200\43\163\116\141\79")]={v7("\140\57\49\140\240\215\234\171\47","\131\223\86\93\227\208\148"),v7("\196\87\183\165\14\245\192\76\162\175","\213\131\37\214\214\125"),v7("\4\57\48\178\161\5\34\49\166","\129\70\75\69\223"),v7("\96\202\240\236\116\234\71\199\179\202\117\251\95","\143\38\171\147\137\28"),v7("\252\151\186\248\26\163\247\217\150\160","\180\176\226\217\147\99\131"),v7("\253\176\63\8\221\249\12\14\199\160","\103\179\217\79"),v7("\96\184\22\218\1\175\170\94\174","\195\42\215\124\181\33\236"),v7("\41\75\54\57\42\246\77\122\62\42\60","\152\109\57\87\94\69")},[v7("\212\194\6\183\183","\200\153\183\106\195\222\178\52")]=false,[v7("\22\230\142\60\92\86\38","\58\82\131\232\93\41")]=2 -1 });v81.Teleport:AddButton({[v7("\183\94\196\25\88","\95\227\55\176\117\61")]=v7("\44\123\47\78\187\23\108\55","\203\120\30\67\43"),[v7("\213\32\94\236\203\248\53\89\230\214\255","\185\145\69\45\143")]=v7("\190\26\21\163\204\133\13\13\230\200\133\95\13\174\217\202\12\28\170\217\137\11\28\162\156\131\12\21\167\210\142\81","\188\234\127\121\198"),[v7("\27\51\31\143\58\51\16\136","\227\88\82\115")]=function() local v162=0;local v163;local v164;while true do if (1==v162) then if v164 then local v196=0 + 0 ;local v197;local v198;while true do if (1==v196) then v198=game:GetService(v7("\50\76\236\234\7\82\254","\147\98\32\141")).LocalPlayer;if v198.Character then v198.Character:BreakJoints();end break;end if (0==v196) then v197={[1236 -(1030 + 205) ]={[1]={[v7("\102\9\191\169\22","\19\35\127\218\199\98")]=v7("\63\243\11\236\27\254\57\242\29\236\4","\130\124\155\106"),[v7("\230\219\247\184\173","\223\181\171\150\207\195\150\28")]=v164},[2 + 0 ]="\n"}};game:GetService(v7("\126\63\243\162\0\79\59\247\171\13\127\46\236\188\8\75\63","\105\44\90\131\206")):WaitForChild(v7("\221\242\187\189\15\59\209\229\166\235","\94\159\128\210\217\104")):WaitForChild(v7("\84\248\18\190\109\122\244\117\68\252\35\169\90\113\237","\26\48\153\102\223\63\31\153")):FireServer(unpack(v197));v196=1;end end end break;end if (v162==0) then local v188=0;while true do if (v188==(0 + 0)) then v163=v104.Value;v164=v82[v163];v188=287 -(156 + 130) ;end if (v188==(2 -1)) then v162=1;break;end end end end end});v9:SetLibrary(v8);v10:SetLibrary(v8);v9:IgnoreThemeSettings();v10:SetFolder(v7("\50\66\250\226\19\84","\43\120\35\131\170\102\54"));v9:SetFolder(v7("\126\7\158\158\176\178\203\71\22\130\181\172\182\141\87\75\128\183\168\181","\228\52\102\231\214\197\208"));v10:BuildInterfaceSection(v81.Settings);v9:BuildConfigSection(v81.Settings);v9:LoadAutoloadConfig();
