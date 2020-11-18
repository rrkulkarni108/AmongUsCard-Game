classdef AmongUsCardGame_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                matlab.ui.Figure
        RoleAssign              matlab.ui.control.Button
        ShuffleButton           matlab.ui.control.Button
        PlayerColorButtonGroup  matlab.ui.container.ButtonGroup
        Player1RedButton        matlab.ui.control.ToggleButton
        Player2BlueButton       matlab.ui.control.ToggleButton
        DrawButton              matlab.ui.control.Button
    end

    
    properties (Access = public)
        myPlayerNum    % Player 1:Red or Player 2:Blue?
        otherPlayerNum % Number of other player whose turn is after yours
        channelID % ThingSpeak Channel ID
        writeKey % Channel Write API Key
        readKey % Channel Read API Key
        readDelay % wait 5 seconds between ThingSpeak Channel Reads
        writeDelay % wait 5 seconds between ThingSpeak Channel Writings
        taskDeck % shuffle deck of task cards (no imposter cards in 2 player)
        myLastDrawnCard % card that this player most recently drew
        otherPlayerLastDrawnCard % card that the other player most recently drew
        
    end
    
    methods (Access = public)
        function startupFcn(app)
             app.myPlayerNum = 1;
             app.otherPlayerNum = 2;
             app.taskDeck = [];
             
             %ID of CHANNEL ASSIGNED
             app.channelID =  1233879;
             
             %WRITE API KEY OF CHANNEL
             app.writeKey = 'MTUX56SDZ2BJDG5J';
             
             %READ API KEY OF CHANNEL
             app.readKey = '28HCRPFLSZZGCERE';
             
             app.readDelay = 5;
             app.writeDelay = 5;
             app.clearThingSpeakChannel();
             set(app.Drawbutton,'Enable','off');
             
             app.myLastDrawnCard.task = 0;
             app.otherPlayerLastDrawnCard.task = 0;
        end
    
        function myPlayerNumColorButtonGroupChanged(app,event)
            selectedToggleButton = app.PlayerColorButtonGroup.SelectedObject;
            if selectedToggleButton == app.Player1RedButton
                app.myPlayerNum = 1;
                app.otherPlayerNum = 2;
            else
                app.myPlayerNum = 2;
                app.otherPlayerNum = 1;
            end
        end
        %clears any data from previous games in thingspeak channel before you
        %start a new game
        function [] = ClearThingSpeakChannel(app)
            thingSpeakWrite(app.channelID, 'Fields', 1, 'Values','WriteKey',app.writeKey);
        end
        
        function startButtonPushed(app,event)
            set(app.Player1RedButton,'Enable','off');
            set(app.Player2BlueButton,'Enable','off');
            set(app.StartButton,'Enable','off');
            
            if(app.myPlayerNum == 1)
                set(app.DrawButton, 'Enable','on');
                app.ResetTaskDeck();
            %app.myPlayerNum = 2
            else 
                app.WaitForOtherPlayer();
                app.UpdateStatus(app.GetCardName(app.myLastDrawnCard),...
                    app.GetCardName(app.otherPlayerLastDrawnCard));
                set(app.DrawButton,'Enable','on');
            end
            
        end
        
        function DrawButtonPushed (app,event)
            app.myLastDrawnCard = app.DrawCard();
            
            app.UpdateStatus(app.GetCardName(app.myLastDrawnCard),...
                app.GetCardName(app.otherPlayerLastDrawnCard));
            
            set(app.DarwButton,'Enable','off');
            
            app.SendDataToOtherPlayer();
            
            %At this point, player 1 is already displaying both cards 
            %so the cards variables can be set to blank
            if(app.myPlayerNum ==2)
                app.ClearPlayerCards();
            end
            app.waitForOtherPlayer();
            
            %At this point, player 1 is already displaying both cards 
            %so the cards variables can be set to blank
            if(app.myPlayerNum ==1)
                app.ClearPlayerCards();
            end
            app.waitForOtherPlayer();
        end
        
        function [] = Shuffle(app)
            %randperm returns a row vector 
            %containing a random permutation of the integers from 1 to n
            app.taskDeck = app.taskDeck(randperm(length(app.taskDeck)));
            
        end
        function [] = ResetTaskDeck(app)
            app.taskDeck = [];
            for task = 1:15
                for val = 1:5
                    card.task = task;
                    card.val = val;
                    app.taskDeck = [app.taskDeck,card];
                end
            end
            app.Shuffle();
        end
        
        function [drawnCard] = DrawCard(app)
            drawnCard = app.taskDeck(end);
            app.taskDeck(end)= [];
        end
        
        function [] = ClearPlayerCards(app)
            app.myLastDrawnCard.task = 0;
            app.otherPlayerLastDrawnCard.task = 0;
        end
        
        function [] UpdateStatus(app,myCardString, otherPlayerCardString)
            p1CardString = "";
            p2CardString = "";
            
            if(app.myPlayerNum == 1)
                p1CardString = myCardString;
                p2CardString - otherPlayerCardString;
            else
                p1CardString = otherPlayerCardString;
                p2CardString = myCardString;
            end
            app.StatusLabel.Text = ["Player 1: " + p1CardString ; "Player 2: " + p2CardString];
        end
        
    end
        

    % Callbacks that handle component events
    methods (Access = private)

        % Code that executes after component creation
        function startupFcn(app, crewmate1, crewmate2)
            
        end

        % Button pushed function: RoleAssign
        function RoleAssignPushed(app, event)
            role = roleAssign(AmongUsCardGame);
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 640 480];
            app.UIFigure.Name = 'MATLAB App';

            % Create RoleAssign
            app.RoleAssign = uibutton(app.UIFigure, 'push');
            app.RoleAssign.ButtonPushedFcn = createCallbackFcn(app, @RoleAssignPushed, true);
            app.RoleAssign.BackgroundColor = [0.1569 0.6314 0.1373];
            app.RoleAssign.FontSize = 15;
            app.RoleAssign.FontColor = [1 1 1];
            app.RoleAssign.Position = [204 173 195 46];
            app.RoleAssign.Text = 'START';

            % Create ShuffleButton
            app.ShuffleButton = uibutton(app.UIFigure, 'push');
            app.ShuffleButton.BackgroundColor = [0.7569 0.4784 0.9216];
            app.ShuffleButton.FontSize = 15;
            app.ShuffleButton.FontColor = [1 1 1];
            app.ShuffleButton.Position = [27 374 100 25];
            app.ShuffleButton.Text = 'Shuffle';

            % Create PlayerColorButtonGroup
            app.PlayerColorButtonGroup = uibuttongroup(app.UIFigure);
            app.PlayerColorButtonGroup.Title = 'Pick Your Player Color';
            app.PlayerColorButtonGroup.Position = [338 359 142 104];

            % Create Player1RedButton
            app.Player1RedButton = uitogglebutton(app.PlayerColorButtonGroup);
            app.Player1RedButton.Text = 'Player 1: Red';
            app.Player1RedButton.BackgroundColor = [1 0 0];
            app.Player1RedButton.FontColor = [1 1 1];
            app.Player1RedButton.Position = [11 51 100 22];
            app.Player1RedButton.Value = true;

            % Create Player2BlueButton
            app.Player2BlueButton = uitogglebutton(app.PlayerColorButtonGroup);
            app.Player2BlueButton.Text = 'Player 2: Blue';
            app.Player2BlueButton.BackgroundColor = [0 0 1];
            app.Player2BlueButton.FontColor = [1 1 1];
            app.Player2BlueButton.Position = [11 30 100 22];

            % Create DrawButton
            app.DrawButton = uibutton(app.UIFigure, 'push');
            app.DrawButton.BackgroundColor = [1 1 0.0667];
            app.DrawButton.FontSize = 20;
            app.DrawButton.Position = [21 197 111 163];
            app.DrawButton.Text = 'Draw';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = AmongUsCardGame_exported(varargin)

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            % Execute the startup function
            runStartupFcn(app, @(app)startupFcn(app, varargin{:}))

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end