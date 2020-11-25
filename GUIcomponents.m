classdef GUIcomponents < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure             matlab.ui.Figure
        CardTable            matlab.ui.control.Image
        SettingsButton       matlab.ui.control.Image
        MapButton            matlab.ui.control.Image
        PlayerProfile        matlab.ui.control.Image
        TaskBarFiller        matlab.ui.control.Label
        TaskBarEmpty         matlab.ui.control.Image
        Deck                 matlab.ui.control.Image
        HelpButton           matlab.ui.control.Image
        PlayerTable1         matlab.ui.control.Image
        CardPile             matlab.ui.control.Image
        SYSTEMMESSAGESPanel  matlab.ui.container.Panel
        TextArea             matlab.ui.control.TextArea
        Shuffle              matlab.ui.control.Image
        PlayerTable1_2       matlab.ui.control.Image
        PlayerTable1_3       matlab.ui.control.Image
        PlayerTable1_4       matlab.ui.control.Image
        Task8                matlab.ui.control.Image
        Task7                matlab.ui.control.Image
        Task6                matlab.ui.control.Image
        Task5                matlab.ui.control.Image
        Task4                matlab.ui.control.Image
        Task3                matlab.ui.control.Image
        Task2                matlab.ui.control.Image
        Task1                matlab.ui.control.Image
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Callback function
        function Task2ImageClicked(app, event)
            app.Task4.Position=[137 0 76 109];
        end

        % Image clicked function: Deck
        function DeckClicked(app, event)
            
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Color = [0.3333 0.3333 0.3333];
            app.UIFigure.Position = [100 100 1148 646];
            app.UIFigure.Name = 'MATLAB App';

            % Create CardTable
            app.CardTable = uiimage(app.UIFigure);
            app.CardTable.Position = [151 46 876 476];
            app.CardTable.ImageSource = 'CardTable.gif';

            % Create SettingsButton
            app.SettingsButton = uiimage(app.UIFigure);
            app.SettingsButton.HorizontalAlignment = 'right';
            app.SettingsButton.Position = [1058 551 91 92];
            app.SettingsButton.ImageSource = 'SettingsButton.gif';

            % Create MapButton
            app.MapButton = uiimage(app.UIFigure);
            app.MapButton.HorizontalAlignment = 'right';
            app.MapButton.Position = [1058 469 88 83];
            app.MapButton.ImageSource = 'MapButton.gif';

            % Create PlayerProfile
            app.PlayerProfile = uiimage(app.UIFigure);
            app.PlayerProfile.Position = [11 573 72 70];
            app.PlayerProfile.ImageSource = 'CrewPurple.gif';

            % Create TaskBarFiller
            app.TaskBarFiller = uilabel(app.UIFigure);
            app.TaskBarFiller.BackgroundColor = [0.3922 0.8314 0.0745];
            app.TaskBarFiller.FontColor = [0.3922 0.8314 0.0745];
            app.TaskBarFiller.Position = [87 590 495 37];

            % Create TaskBarEmpty
            app.TaskBarEmpty = uiimage(app.UIFigure);
            app.TaskBarEmpty.Position = [82 585 507 45];
            app.TaskBarEmpty.ImageSource = 'TaskBarTransparent.gif';

            % Create Deck
            app.Deck = uiimage(app.UIFigure);
            app.Deck.ImageClickedFcn = createCallbackFcn(app, @DeckClicked, true);
            app.Deck.Position = [413 338 135 123];
            app.Deck.ImageSource = 'DeckPile.gif';

            % Create HelpButton
            app.HelpButton = uiimage(app.UIFigure);
            app.HelpButton.HorizontalAlignment = 'right';
            app.HelpButton.Position = [1065 384 78 77];
            app.HelpButton.ImageSource = 'HelpButton.gif';

            % Create PlayerTable1
            app.PlayerTable1 = uiimage(app.UIFigure);
            app.PlayerTable1.Position = [549 478 79 96];
            app.PlayerTable1.ImageSource = 'CrewBlue.gif';

            % Create CardPile
            app.CardPile = uiimage(app.UIFigure);
            app.CardPile.Position = [466 235 218 160];
            app.CardPile.ImageSource = 'DeckCardsPlayed.gif';

            % Create SYSTEMMESSAGESPanel
            app.SYSTEMMESSAGESPanel = uipanel(app.UIFigure);
            app.SYSTEMMESSAGESPanel.ForegroundColor = [0.149 0.149 0.149];
            app.SYSTEMMESSAGESPanel.TitlePosition = 'centertop';
            app.SYSTEMMESSAGESPanel.Title = 'SYSTEM MESSAGES ';
            app.SYSTEMMESSAGESPanel.BackgroundColor = [0.651 0.651 0.651];
            app.SYSTEMMESSAGESPanel.FontSize = 16;
            app.SYSTEMMESSAGESPanel.Position = [11 429 346 136];

            % Create TextArea
            app.TextArea = uitextarea(app.SYSTEMMESSAGESPanel);
            app.TextArea.BackgroundColor = [0.651 0.651 0.651];
            app.TextArea.Position = [12 19 318 85];
            app.TextArea.Value = {'Disaster!'};

            % Create Shuffle
            app.Shuffle = uiimage(app.UIFigure);
            app.Shuffle.Position = [35 248 136 147];
            app.Shuffle.ImageSource = 'ShuffleCard.gif';

            % Create PlayerTable1_2
            app.PlayerTable1_2 = uiimage(app.UIFigure);
            app.PlayerTable1_2.Position = [205 267 79 96];

            % Create PlayerTable1_3
            app.PlayerTable1_3 = uiimage(app.UIFigure);
            app.PlayerTable1_3.Position = [791 449 79 96];

            % Create PlayerTable1_4
            app.PlayerTable1_4 = uiimage(app.UIFigure);
            app.PlayerTable1_4.Position = [894 267 79 96];

            % Create Task8
            app.Task8 = uiimage(app.UIFigure);
            app.Task8.Position = [-7 0 159 188];
            app.Task8.ImageSource = 'ProjTask6.gif';

            % Create Task7
            app.Task7 = uiimage(app.UIFigure);
            app.Task7.Position = [35 1 159 188];
            app.Task7.ImageSource = 'ProjTask7.gif';

            % Create Task6
            app.Task6 = uiimage(app.UIFigure);
            app.Task6.Position = [110 3 139 188];
            app.Task6.ImageSource = 'ProjTask8.gif';

            % Create Task5
            app.Task5 = uiimage(app.UIFigure);
            app.Task5.Position = [283 3 120 180];
            app.Task5.ImageSource = 'ProjTask1.gif';

            % Create Task4
            app.Task4 = uiimage(app.UIFigure);
            app.Task4.Position = [402 2 124 182];
            app.Task4.ImageSource = 'ProjTask2.gif';

            % Create Task3
            app.Task3 = uiimage(app.UIFigure);
            app.Task3.Position = [525 -2 124 186];
            app.Task3.ImageSource = 'ProjTask3.gif';

            % Create Task2
            app.Task2 = uiimage(app.UIFigure);
            app.Task2.Position = [648 2 120 183];
            app.Task2.ImageSource = 'ProjTask4.gif';

            % Create Task1
            app.Task1 = uiimage(app.UIFigure);
            app.Task1.Position = [767 -3 128 195];
            app.Task1.ImageSource = 'ProjTask5.gif';

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = GUIcomponents

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

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