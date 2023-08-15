% John Swanson
% ENGR 102
% Section H04
%% First - Display matrix of alphabet used for encrypting

clc, clear
% Display every possible caesar shift in one matrix
% This Matrix will be used to both encrypt and decrypt inputted message
num_rows = 26;
MAT = [];   
CS = 'ZABCDEFGHIJKLMNOPQRSTUVWXY';      % Define first Caesar shift
Alph = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';    % Define Alphabet

for r = 1:num_rows;  % Use for loop for generate matrix. It will cycle through every row (which is same length as alphabet)
    CS = [CS, CS(1)]; % Add first element of the first Caesar shift (being Z for the first loop)
    CS(1) = []; % Take away the first element of that first Caesar shift (this generates your alphabet during its first time through loop) 
    MAT = [MAT; CS]; % Add this Caesar shift to matrix. The last Matrix generated is the 26x26 matrix used to encrypt and decrypt.
    encoded_M = ''; % Use quotes not [] since your dealing with letters 
    % Code needs to be able to recognize letters within encoded message,
    % then recognize letters within key phrase and match the two with a
    % corresponding letter within the matrix (For encoding). For decoding,
    % code should recognize the column each letter the key is in, find each
    % letter of the encoded message according to those corresponding columns,
    % then output the letter in column one. After every pass through a loop,
    % the outputted letters will eventually give you the encoded message. 
    % This will be done within a seperate loop.
end
%disp(MAT)

% Decide whether to encrypt/decrypt
% Define something (literally) = 0 outside a while loop. This while loop is
% a catch so that everything must pass through every nested loop so that something
% doesn't equal zero before ending loop.
something = 0;
while something == 0
    something = 1;
    decide = input('Enter 1 if you want to encode, enter 0 if you want to decode:   ');
    % So if they decide to encrypt ...
    if decide == 1
        
        % User should input what they want the message to be
        % Use upper function to ensure all letters are capital
        Secret_M = upper(input('Input your message:   ','s')); 
        % Convert Secret_M to all letters
        x = 1;
        while x <= length(Secret_M)   % While loop is used because the length of secret message is unknown. User may input a bunch of numbers, which will not pass through loop.
            isavar = 0;      
            % Compare message to letters in the alphabet
            for t = 1:length(Alph)
                if Secret_M(x) == Alph(t)  % If they are letters...
                    isavar = 1;   % Let isavar = 1
                end
            end
            % Now you have a bunch of zeros that need to go away.
            % If it's not a letter, it shouldn't be displayed.
            if isavar == 0
                Secret_M(x) = ''; % This ensures the zeros are not listed. Only want the ones which are letters.
            else
                x = x+1; % This is to check every index. But the while loop will ensure it doesn't try to pass through an index that shouldn't be there.
            end
        end
        
        % Once message is converted to all uppercase letters (no special
        % characters), have user input keyphrase.
        % Basically same requirements as Secret_M ... no special characters
        % However, it also must be longer than the Secret_M so an
        % additional while loop will need to be used.
        bad = 0;
        while bad == 0 % This while loop ensures the user inputs a keyphrase that is longer than the message to be encrypted/decrypted
            keyphrase = upper(input('Input your keyphrase:   ','s')); % Again,use upper function to convert all inputs to capital letters 
            % Convert keyphrase to all letters
            % Get rid of any special characters
            % Use same while loop used for the Secret_M but change
            % variables.
            x = 1;
            while x <= length(keyphrase) 
                isavar = 0;
                for t = 1:length(Alph)
                    if keyphrase(x) == Alph(t)
                        isavar = 1;   % Find if it is a letter
                    end
                end
                if isavar == 0
                    keyphrase(x) = ''; % This ensures numbers are not listed
                else
                    x = x+1; % This is to check every index
                end
            end
            
            % Now, use if statement to ensure use inputs a keyphrase that
            % is longer than the message. 
            if length(keyphrase) >= length(Secret_M)
                bad = 1; % When bad is not 1, this if statement will prompt the user to type in a longer keyphrase.
            else 
                disp('Try a keyphrase that is longer than the message') % Once user inputs a keyphrase such that length(keyphrase) >= length(Secret_M), bad will = 1 and everything will pass through this while loop.
            end
        end
        
        % After removing all of the special characters ...
        % Get keyphrase and secret message to be the same length
        lengthofkeyphrase = length(keyphrase);
        lengthofmessage = length(Secret_M);
        
        if lengthofkeyphrase == lengthofmessage;
            newkey = keyphrase; % If already equal, perfect. newkey will be the same as keyphrase
        elseif lengthofkeyphrase > lengthofmessage;
            newkey = keyphrase(1:lengthofmessage); % If keyphrase is greater, newkey will just be the terms 1 through however many terms there are in Secret_M
        end
        
        % Now if the user decides to encrypt...
        for r = 1:length(newkey) % This loop runs through the length of the newkey and eventually generates every encoded letter.
            % Use for loop to identify intersection of the newkey's column
            % and define it as column
            for c = 1:num_rows
                % decide if the first letter is A, B, ...
                if MAT(1,c) == newkey(r) % Use MAT matrix and find where letter of key is in first row since newkey is used in the first row.
                    column = c;
                end
            end
            % Now use for loop to identify the row of the message and
            % define it as rowone
            for row = 1:num_rows
                % decide if the first letter is A, B, ...
                if MAT(1,row) == Secret_M(r) % Locate every letter in the secret message within matrix
                    rowone = row;
                end
            end
            encoded_M(r) =  MAT(rowone,column); % Need to generate every letter in the encoded message that intersects with rowone and column
        end
        
        fprintf('This is the encoded message: %s \n', encoded_M)
        
    % But if they decide to decrypt...
    % Use nearly same loop as loop for encrypting
    elseif decide == 0
        
        
        Encoded_M = upper(input('Input your encoded message:   ','s'));
        
        % Convert Encoded_M to all letters
        x = 1;
        while x <= length(Encoded_M)
            isavar = 0;
            % Compare message to letters in the alphabet
            for t = 1:length(Alph)
                if Encoded_M(x) == Alph(t)
                    isavar = 1;   % Find if it is a letter
                end
            end
            % If it's not a letter, it shouldn't be displayed
            if isavar == 0
                Encoded_M(x) = ''; % This ensures numbers are not listed
            else
                x = x+1; % This is to check every index
            end
        end
        
        bad = 0;
        while bad == 0
            
            keyphrase = upper(input('Input your keyphrase:   ','s')); % This stays the same as code for encrypting since user will input keyphrase regardless.
            
            % Change keyphrase to all letters
            % Convert all characters in keyphrase to uppercase letters
            x = 1;
            while x <= length(keyphrase)
                isavar = 0;
                for t = 1:length(Alph)
                    if keyphrase(x) == Alph(t)
                        isavar = 1;   % Find if it is a letter
                    end
                end
                if isavar == 0
                    keyphrase(x) = ''; % This ensures numbers are not listed
                else
                    x = x+1; % This is to check every index
                end
            end
            
            if length(keyphrase) >= length(Encoded_M) % Now keyphrase must be >= the encoded message
                bad = 1;
            else 
                disp('Try a keyphrase that is longer than the encoded message')
            end
        end
        
        
        % Get keyphrase and secret message to be the same length
        lengthofkeyphrase = length(keyphrase);
        lengthofmessage = length(Encoded_M);
        
        if lengthofkeyphrase == lengthofmessage
            newkey = keyphrase;
        elseif lengthofkeyphrase > lengthofmessage
            newkey = keyphrase(1:lengthofmessage);
        end
        
        for r = 1:length(newkey) % What letter we are at
            
            for c = 1:num_rows
                % decide if the first letter is A, B, ...
                if MAT(1,c) == newkey(r) % Find where letter of key is in first row
                    column = c;
                end
            end
            for row = 1:num_rows
                % decide if the first letter is A, B, ...
                if MAT(row,column) == Encoded_M(r) % Find where letter of message is in first row
                    rowone = row; 
                end
            end
            Secret_M(r) =  MAT(rowone,1); % Now you must use MAT(rowone,1) instead of MAT(rowone,column) because the secret message is found using only column 1. 
        end
        fprintf('This is the decrypted message: %s \n', Secret_M)
    else
        disp('Try again')
        something = 0;
    end
end



