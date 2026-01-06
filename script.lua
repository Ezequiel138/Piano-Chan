                                                                                 local Players=game:   
                                                                        GetService("Players");local UserInputService=   
                                                                    game:GetService("UserInputService");local VirtualInputManager 
                                                                =game:GetService("VirtualInputManager");local ContextActionService=game 
                                                            :GetService("ContextActionService");local HttpService=game:GetService(        
                                                          "HttpService");local player=Players.LocalPlayer;local targetParent=(game:         
                                                        GetService("CoreGui"):FindFirstChild("RobloxGui") and game:GetService("CoreGui")) or  
                                                      player:WaitForChild("PlayerGui") ;local SOUND_ID="rbxassetid://5039052146";local function 
                                                     playEffect() local s=Instance.new("Sound",game:GetService("SoundService"));s.SoundId=        
                                                  SOUND_ID;s.Volume=2;s:Play();s.Ended:Connect(function() s:Destroy();end);end local FILE_NAME=     
                                                  "PianoChan_Data.json";local ACTION_NAME="PianoChanBlocker";local function saveToDevice(data) local  
                                                success,encoded=pcall(function() return HttpService:JSONEncode(data);end);if success then writefile(    
                                                FILE_NAME,encoded);end end local function loadFromDevice() if isfile(FILE_NAME) then local content=       
                                              readfile(FILE_NAME);local success,decoded=pcall(function() return HttpService:JSONDecode(content);end);if     
                                              success then return decoded;end end return nil;end local Languages={English={Play="PLAY",Stop="STOP",Clean=   
                                            "CLEAN",Saves="SAVES",Config="SETTINGS",Load="LOAD",Save="SAVE",Close="CLOSE",Lang="Language: ",Manual="Manual: " 
                                            ,Key="Key: "},["Español"]={Play="TOCAR",Stop="PARAR",Clean="LIMPIAR",Saves="LISTA",Config="AJUSTES",Load="CARGAR",  
                                          Save="GUARDAR",Close="CERRAR",Lang="Idioma: ",Manual="Manual: ",Key="Tecla: "},["Français"]={Play="JOUER",Stop=         
                                          "ARRÊTER",Clean="EFFACER",Saves="SAUVE",Config="RÉGLAGES",Load="CHARGER",Save="GARDER",Close="FERMER",Lang="Langue: ",    
                                          Manual="Manuel: ",Key="Touche: "},["日本語"]={Play="再生",Stop="停止",Clean="クリア",Saves="保存",Config="設定",Load="読み込む",Save="保存する",  
                                          Close="閉じる",Lang="言語: ",Manual="マニュアル: ",Key="キー: "}};local savedData=loadFromDevice();local PianoData=savedData or {       
                                        Language="English",ManualMode=false,ManualKey="P",Saves={}} ;local currentManualKeyCode=Enum.KeyCode[PianoData.ManualKey];local 
                                         curLang=Languages[PianoData.Language];local isBinding=false;local    --[[==============================]]isPlaying,index,        
                                        notesList,playThread=false,1,{},nil;local function          --[[============================================]]pressNote(noteStr)  
                                        local clean=noteStr:gsub("[%[%]]","");for i=1, #clean   --[[======================================================]]do local char=  
                                      clean:sub(i,i):upper();local code;if char:match("%d") --[[==========================================================]] then local       
                                      numNames={["0"]="Zero",["1"]="One",["2"]="Two",["3" --[[==============================================================]]]="Three",["4"] 
                                      ="Four",["5"]="Five",["6"]="Six",["7"]="Seven",["8" --[[================================================================]]]="Eight",["9"] 
                                      ="Nine"};code=Enum.KeyCode[numNames[char]];else     --[[==================================================================]]pcall(        
                                      function() code=Enum.KeyCode[char];end);end if code --[[==================================================================]] then             
                                    VirtualInputManager:SendKeyEvent(true,code,false,game --[[====================================================================]]);task.wait(  
                    0.01);VirtualInputManager:SendKeyEvent(false,code,false,game);end end --[[====================================================================]] end local      
              function handleBlockAction(actionName,inputState,inputObject) if            --[[======================================================================]]              
            UserInputService:GetFocusedTextBox() then return Enum.ContextActionResult.    --[[======================================================================]]Pass;end if ( 
          PianoData.ManualMode and isPlaying and (inputObject.KeyCode==                   --[[======================================================================]]              
        currentManualKeyCode)) then if (inputState==Enum.UserInputState.Begin) then if (  --[[======================================================================]]index<= #     
        notesList) then pressNote(notesList[index]);index=index + 1 ;else isPlaying=false --[[======================================================================]];end end      
      return Enum.ContextActionResult.Sink;end if (PianoData.ManualMode and (inputObject. --[[======================================================================]]KeyCode==     
      currentManualKeyCode)) then return Enum.ContextActionResult.Sink;end return Enum.     --[[==================================================================]]                
      ContextActionResult.Pass;end local function updateKeyBlock() ContextActionService:    --[[================================================================]]UnbindAction(     
    ACTION_NAME);ContextActionService:BindAction(ACTION_NAME,handleBlockAction,false,       --[[==============================================================]]                  
    currentManualKeyCode);end local NotifyGui=Instance.new("ScreenGui",targetParent);local    --[[==========================================================]]function notify(msg 
    ) local nFrame=Instance.new("Frame",NotifyGui);nFrame.Size=UDim2.new(0,300,0,50);nFrame.    --[[====================================================]]Position=UDim2.new(0.5, 
     -150, -0.15,0);nFrame.BackgroundColor3=Color3.fromRGB(45,45,55);nFrame.BorderSizePixel=0;    --[[==============================================]]Instance.new("UICorner",  
    nFrame);local s=Instance.new("UIStroke",nFrame);s.Color=Color3.fromRGB(120,80,200);s.Thickness=2; --[[====================================]]local txt=Instance.new(       
    "TextLabel",nFrame);txt.Size=UDim2.new(1,0,1,0);txt.BackgroundTransparency=1;txt.Text="🌸 "   .. msg  --[[========================]]   .. " 🌸" ;txt.TextColor3=Color3.   
    new(1,1,1);txt.Font=Enum.Font.FredokaOne;txt.TextScaled=true;nFrame:TweenPosition(UDim2.new(0.5, -150,0.05,0),"Out","Back",0.5,true);task.delay(2.5,function() if       
  nFrame then nFrame:TweenPosition(UDim2.new(0.5, -150, -0.15,0),"In","Sine",0.5,true);task.wait(0.5);nFrame:Destroy();end end);end local PianoGui=Instance.new(          
  "ScreenGui",targetParent);local MainFrame=Instance.new("Frame",PianoGui);MainFrame.Size=UDim2.new(0,550,0,480);MainFrame.Position=UDim2.new(0.5, -275,0.5, -240);     
  MainFrame.BackgroundColor3=Color3.fromRGB(30,30,35);Instance.new("UICorner",MainFrame);Instance.new("UIStroke",MainFrame).Color=Color3.fromRGB(120,80,200);local        
  MainTitle=Instance.new("TextLabel",MainFrame);MainTitle.Size=UDim2.new(1,0,0,70);MainTitle.Text="Piano-Chan";MainTitle.Font=Enum.Font.FredokaOne;MainTitle.TextScaled=  
  true;MainTitle.TextColor3=Color3.new(1,1,1);MainTitle.BackgroundTransparency=1;local Sheets=Instance.new("TextBox",MainFrame);Sheets.Size=UDim2.new(0,480,0,150);Sheets 
  .Position=UDim2.new(0.5, -240,0.18,0);Sheets.MultiLine=true;Sheets.TextWrapped=true;Sheets.BackgroundColor3=Color3.fromRGB(50,50,60);Sheets.TextColor3=Color3.new(1,1,1 
  );Sheets.Font=Enum.Font.FredokaOne;Sheets.PlaceholderText="Partitura...";Instance.new("UICorner",Sheets);local PlayBtn=Instance.new("TextButton",MainFrame);PlayBtn.    
  Size=UDim2.new(0,130,0,55);PlayBtn.Position=UDim2.new(0.05,0,0.8,0);PlayBtn.BackgroundColor3=Color3.fromRGB(120,80,200);PlayBtn.TextColor3=Color3.new(1,1,1);PlayBtn.   
  Font=Enum.Font.FredokaOne;PlayBtn.TextScaled=true;Instance.new("UICorner",PlayBtn);local CleanBtn=Instance.new("TextButton",MainFrame);CleanBtn.Size=UDim2.new(0,100,0, 
  55);CleanBtn.Position=UDim2.new(0.3,0,0.8,0);CleanBtn.BackgroundColor3=Color3.fromRGB(120,80,200);CleanBtn.TextColor3=Color3.new(1,1,1);CleanBtn.Font=Enum.Font.        
  FredokaOne;CleanBtn.TextScaled=true;Instance.new("UICorner",CleanBtn);local SavePanelBtn=Instance.new("TextButton",MainFrame);SavePanelBtn.Size=UDim2.new(0,100,0,55);  
  SavePanelBtn.Position=UDim2.new(0.5,0,0.8,0);SavePanelBtn.BackgroundColor3=Color3.fromRGB(120,80,200);SavePanelBtn.TextColor3=Color3.new(1,1,1);SavePanelBtn.Font=Enum.   
  Font.FredokaOne;SavePanelBtn.TextScaled=true;Instance.new("UICorner",SavePanelBtn);local Bpm=Instance.new("TextBox",MainFrame);Bpm.Text="150";Bpm.Size=UDim2.new(0,70,0,  
  55);Bpm.Position=UDim2.new(0.7,0,0.8,0);Bpm.BackgroundColor3=Color3.fromRGB(50,50,60);Bpm.TextColor3=Color3.new(1,1,1);Bpm.Font=Enum.Font.FredokaOne;Bpm.TextScaled=true; 
  Instance.new("UICorner",Bpm);local BpmLabel=Instance.new("TextLabel",MainFrame);BpmLabel.Text="BPM";BpmLabel.Size=UDim2.new(0,70,0,20);BpmLabel.Position=UDim2.new(0.7,0, 
  0.91,0);BpmLabel.BackgroundTransparency=1;BpmLabel.TextColor3=Color3.new(1,1,1);BpmLabel.TextTransparency=0.75;BpmLabel.Font=Enum.Font.FredokaOne;BpmLabel.TextSize=14;   
  local ConfigBtn=Instance.new("ImageButton",MainFrame);ConfigBtn.Image="rbxassetid://17124529105";ConfigBtn.Size=UDim2.new(0,45,0,45);ConfigBtn.Position=UDim2.new(0.86,0, 
  0.81,0);ConfigBtn.BackgroundTransparency=1;local DestroyBtn=Instance.new("TextButton",MainFrame);DestroyBtn.Text="X";DestroyBtn.Size=UDim2.new(0,40,0,40);DestroyBtn.     
  Position=UDim2.new(0.92,0,0.02,0);DestroyBtn.BackgroundColor3=Color3.fromRGB(200,50,50);DestroyBtn.TextColor3=Color3.new(1,1,1);Instance.new("UICorner",DestroyBtn);local 
   SaveFrame=Instance.new("Frame",PianoGui);SaveFrame.Size=UDim2.new(0,400,0,450);SaveFrame.Position=UDim2.new(0.5,300,0.5, -225);SaveFrame.Visible=false;SaveFrame.        
  BackgroundColor3=Color3.fromRGB(30,30,35);Instance.new("UICorner",SaveFrame);Instance.new("UIStroke",SaveFrame).Color=Color3.fromRGB(120,80,200);local Scroll=Instance.   
  new("ScrollingFrame",SaveFrame);Scroll.Size=UDim2.new(1,0,0.85,0);Scroll.Position=UDim2.new(0,0,0.12,0);Scroll.BackgroundTransparency=1;Scroll.CanvasSize=UDim2.new(0,0,3 
  ,0);Scroll.ScrollBarThickness=5;for i=1,10 do local slotData=PianoData.Saves[tostring(i)] or {name="Song "   .. i ,sheet=""} ;local slot=Instance.new("Frame",Scroll);    
  slot.Size=UDim2.new(0.9,0,0,120);slot.Position=UDim2.new(0.05,0,0,(i-1) * 130 );slot.BackgroundColor3=Color3.fromRGB(50,50,65);Instance.new("UICorner",slot);local sName= 
  Instance.new("TextBox",slot);sName.Size=UDim2.new(1,0,0,30);sName.Text=slotData.name;sName.TextColor3=Color3.new(1,1,1);sName.BackgroundTransparency=1;sName.Font=Enum. 
  Font.FredokaOne;sName.TextScaled=true;local preview=Instance.new("TextBox",slot);preview.Size=UDim2.new(0.9,0,0,40);preview.Position=UDim2.new(0.05,0,0.3,0);preview.   
  BackgroundColor3=Color3.fromRGB(20,20,30);preview.TextColor3=Color3.new(0.7,0.7,0.7);preview.Text=slotData.sheet;preview.PlaceholderText="Empty Slot...";preview.       
    TextScaled=true;Instance.new("UICorner",preview);local lBtn=Instance.new("TextButton",slot);lBtn.Size=UDim2.new(0.4,0,0,30);lBtn.Position=UDim2.new(0.05,0,0.7,0);    
    lBtn.BackgroundColor3=Color3.fromRGB(120,80,200);lBtn.TextColor3=Color3.new(1,1,1);lBtn.Font=Enum.Font.FredokaOne;lBtn.Text="LOAD";Instance.new("UICorner",lBtn);     
    local sBtn=Instance.new("TextButton",slot);sBtn.Size=UDim2.new(0.4,0,0,30);sBtn.Position=UDim2.new(0.55,0,0.7,0);sBtn.BackgroundColor3=Color3.fromRGB(200,80,120);    
    sBtn.TextColor3=Color3.new(1,1,1);sBtn.Font=Enum.Font.FredokaOne;sBtn.Text="SAVE";Instance.new("UICorner",sBtn);lBtn.MouseButton1Click:Connect(function() Sheets.Text 
      =preview.Text;notify("Loaded: "   .. sName.Text );end);sBtn.MouseButton1Click:Connect(function() preview.Text=Sheets.Text;PianoData.Saves[tostring(i)]={name=     
      sName.Text,sheet=Sheets.Text};saveToDevice(PianoData);notify("Saved! 💾");end);end local ConfigFrame=Instance.new("Frame",PianoGui);ConfigFrame.Size=UDim2.new(0, 
      350,0,380);ConfigFrame.Position=UDim2.new(0.5, -175,0.5, -190);ConfigFrame.Visible=false;ConfigFrame.BackgroundColor3=Color3.fromRGB(30,30,35);Instance.new(      
        "UICorner",ConfigFrame);Instance.new("UIStroke",ConfigFrame).Color=Color3.fromRGB(120,80,200);local LangBtn=Instance.new("TextButton",ConfigFrame);LangBtn.Size 
        =UDim2.new(0,250,0,45);LangBtn.Position=UDim2.new(0.5, -125,0.2,0);LangBtn.BackgroundColor3=Color3.fromRGB(120,80,200);LangBtn.TextColor3=Color3.new(1,1,1);    
        LangBtn.Font=Enum.Font.FredokaOne;LangBtn.TextScaled=true;Instance.new("UICorner",LangBtn);local ManualBtn=Instance.new("TextButton",ConfigFrame);ManualBtn.    
          Size=UDim2.new(0,250,0,45);ManualBtn.Position=UDim2.new(0.5, -125,0.4,0);ManualBtn.BackgroundColor3=Color3.fromRGB(120,80,200);ManualBtn.TextColor3=Color3. 
            new(1,1,1);ManualBtn.Font=Enum.Font.FredokaOne;ManualBtn.TextScaled=true;Instance.new("UICorner",ManualBtn);local KeyBtn=Instance.new("TextButton",       
              ConfigFrame);KeyBtn.Size=UDim2.new(0,250,0,45);KeyBtn.Position=UDim2.new(0.5, -125,0.6,0);KeyBtn.BackgroundColor3=Color3.fromRGB(120,80,200);KeyBtn.    
                TextColor3=Color3.new(1,1,1);KeyBtn.Font=Enum.Font.FredokaOne;KeyBtn.TextScaled=true;Instance.new("UICorner",KeyBtn);local function stopMusic()       
                  isPlaying=false;if playThread then task.cancel(playThread);end PlayBtn.Text=curLang.Play;notify("Stopped");end PlayBtn.MouseButton1Click:Connect( 
                      function() if isPlaying then stopMusic();else notesList={};for n in Sheets.Text:gmatch("%S+") do table.insert(notesList,n);end if ( #         
                                  notesList==0) then return;end isPlaying=true;index=1;PlayBtn.Text=curLang.Stop;if  not PianoData.ManualMode then playThread=task. 
                                      spawn(function() while isPlaying and (index<= #notesList)  do pressNote(notesList[index]);index=index + 1 ;task.wait(60/(     
                                      tonumber(Bpm.Text) or 150) );end stopMusic();end);else notify         ("Manual: Press "   .. currentManualKeyCode.Name );end  
                                      end end);UserInputService.InputBegan:Connect(function(input,          gpe) if (isBinding and  not gpe and (input.           
                                      UserInputType==Enum.UserInputType.Keyboard)) then                     currentManualKeyCode=input.KeyCode;PianoData.         
                                      ManualKey=input.KeyCode.Name;isBinding=false;updateKeyBlock()         ;saveToDevice(PianoData);notify("Key: "   .. input.   
                                      KeyCode.Name );end end);ManualBtn.MouseButton1Click:Connect(            function() PianoData.ManualMode= not PianoData.     
                                      ManualMode;updateKeyBlock();saveToDevice(PianoData);notify(             "Manual: "   .. ((PianoData.ManualMode and "ON") or 
                                       "OFF") );end);KeyBtn.MouseButton1Click:Connect(function()              isBinding=true;notify("Press any key...");end);   
                                        LangBtn.MouseButton1Click:Connect(function() local list={             "English","Español","Français","日本語"};local idx=  
                                        table.find(list,PianoData.Language) or 1 ;PianoData.                    Language=list[(idx% #list) + 1 ];curLang=       
                                        Languages[PianoData.Language];saveToDevice(PianoData);                  notify("Lang: "   .. PianoData.Language );end 
                                        );ConfigBtn.MouseButton1Click:Connect(function()                        ConfigFrame.Visible= not ConfigFrame.Visible; 
                                        end);SavePanelBtn.MouseButton1Click:Connect(function()                    SaveFrame.Visible= not SaveFrame.Visible; 
                                        end);CleanBtn.MouseButton1Click:Connect(function() Sheets                 .Text="";notify("Cleared");end);          
                                          DestroyBtn.MouseButton1Click:Connect(function()                           playEffect();ContextActionService:    
                                          UnbindAction(ACTION_NAME);PianoGui:Destroy();                               NotifyGui:Destroy();end);local  
                                            function drag(f,h) local d,s,p;h.InputBegan:Connect                         (function(i) if (i.       
                                            UserInputType==Enum.UserInputType.MouseButton1)                                   then d=true 
                                              ;s=i.Position;p=f.Position;end end);          
                                                UserInputService.InputChanged:Connect(    
                                                    function(i) if (d and (i.           
                                                          UserInputType==Enum.    


UserInputType.MouseMovement)) then local del=i.Position-s ;f.Position=UDim2.new(p.X.Scale,p.X.Offset + del.X ,p.Y.Scale,p.Y.Offset + del.Y );end end);UserInputService.InputEnded:Connect(function(i) if (i.UserInputType==Enum.UserInputType.MouseButton1) then d=false;end end);end drag(MainFrame,MainTitle);drag(ConfigFrame,LangBtn);drag(SaveFrame,SaveFrame);task.spawn(function() while task.wait(0.1) do if  not isPlaying then PlayBtn.Text=curLang.Play;end CleanBtn.Text=curLang.Clean;SavePanelBtn.Text=curLang.Saves;ManualBtn.Text=curLang.Manual   .. ((PianoData.ManualMode and "ON") or "OFF") ;KeyBtn.Text=(isBinding and "...") or (curLang.Key   .. currentManualKeyCode.Name) ;LangBtn.Text=curLang.Lang   .. PianoData.Language ;end end);updateKeyBlock();playEffect();notify("Piano-Chan on top! 🌸");