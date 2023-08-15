%% ENGR 102 Project 2
% Option D: Beaufort & Porta Ciphers
% Elaine Freed


%% Beaufort Cipher
EoD = menu('Do you wish to encrypt or decrypt your message?','Encrypt','Decrypt');
if EoD == 1 %this just allows the input statement to match conditions
    SM = input('Enter message to be encrypted: \n','s');
else
    SM = input('Enter message to be decrypted: \n','s');
end
KEY = input('Enter key: \n','s');
alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
% clean up the message-----------------------------------------------------
SM = upper(SM);
lth = length(SM); 
newSM = ''; % string variable
for k = 1:lth %so, for each letter of the secret message...
    for a = 1:26
        if SM(k) == alphabet(a)
            newSM = [newSM alphabet(a)]; %store it in a new variable if it's a letter
            %note: had to use this method to concatenate because indexing
            %left 0s/spaces for things that weren't a letter
        end
    end
end
SM = newSM; %now I'm just keeping my variables consistent
% take the key and get it into a usable form-------------------------------
lth = length(SM);
lthk = length(KEY);
KEY = upper(KEY); %if the key isn't in all uppercase, the letters won't 
%pass logical tests
newKEY = ''; %string variable
for k = 1:lthk %so, for each letter of the key...
    for a = 1:26
        if KEY(k) == alphabet(a)
            newKEY = [newKEY alphabet(a)]; %store it in a new variable if it's a letter
        end
    end
end
KEY = newKEY; %now I'm just keeping my variables consistent

%beginning at the end of the given keyword/phrase, and continuing for the
%length of the message....
for k = (lthk + 1):lth 
    KEY = [KEY KEY(k-lthk)]; 
    %copy the letter one keyword-length back onto the end of the key
end

% make the matrix----------------------------------------------------------
MAT = [alphabet]; 
%the first row in the matrix is a ceasar shif of 0, which is the alphabet.
%after that, each row can be added by taking the last row and copying the
%everything from the second element to the last, followed by the first
%element
for k = 2:length(alphabet)
    MAT(k,1:26) = [MAT(k-1,2:26) MAT(k-1,1)];
end
% use numbers & matrix referencing to encode-------------------------------
% this switches the SM to its respective letters of the alphabet (SMN)
SMN = [];
for m = 1:lth %for each letter in the message
    for a = 1:26 %for each letter in the alphabet
        if SM(m) == alphabet(a) %if they equal one another, 
            SMN(m) = a; %take the number that was the position of the letter
            %of the alphabet that matched, and put it in the SMN vector
        end
    end
end
% now actually do the encryption/decryption--------------------------------
for LN = 1:lth %for each value (letter number) in the SMN vector
    for PR = 1:26 %PR for possible result
        %if the letter in the column of the secret message number matches
        %the letter of the key,,,
        if MAT(PR,SMN(LN))==KEY(LN)
            SM(LN) = alphabet(PR);
            %then that letter of the secret message gets switched to the 
            %letter of the alphabet associated with that row
        end
    end
end

%fprintf the result--------------------------------------------------------
if EoD == 1
    fprintf('The encrypted message reads: \n"%s"\n',SM')
else
    fprintf('The decrypted message reads: \n"%s"\n',SM')
end


%% Porta Cipher

EoD = menu('Do you wish to encrypt or decrypt your message?','Encrypt','Decrypt');
if EoD == 1 %this just allows the input statement to match conditions
    SM = input('Enter message to be encrypted: \n','s');
else
    SM = input('Enter message to be decrypted: \n','s');
end
KEY = input('Enter key: \n','s');
alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
% clean up the message-----------------------------------------------------
SM = upper(SM);
lth = length(SM); 
newSM = ''; % string variable
for k = 1:lth %so, for each letter of the secret message...
    for a = 1:26
        if SM(k) == alphabet(a)
            newSM = [newSM alphabet(a)]; %store it in a new variable if it's a letter
            %note: had to use this method to concatenate because indexing
            %left 0s/spaces for things that weren't a letter
        end
    end
end
SM = newSM; %now I'm just keeping my variables consistent
% take the key and get it into a usable form-------------------------------
lth = length(SM);
lthk = length(KEY);
KEY = upper(KEY); %if the key isn't in all uppercase, the letters won't 
%pass logical tests
newKEY = ''; %string variable
for k = 1:lthk %so, for each letter of the key...
    for a = 1:26
        if KEY(k) == alphabet(a)
            newKEY = [newKEY alphabet(a)]; %store it in a new variable if it's a letter
        end
    end
end
KEY = newKEY; %now I'm just keeping my variables consistent

%beginning at the end of the given keyword/phrase, and continuing for the
%length of the message....
for k = (lthk + 1):lth 
    KEY = [KEY KEY(k-lthk)]; 
    %copy the letter one keyword-length back onto the end of the key
end

% create the matrix--------------------------------------------------------
%this table for encryption/decryption kinda has two parts.
%the first one has the second half of the alphabet shifted left for each
%successive row, and the second half has each row shifted right, so I had
%to make two matrices and then put them together.
MAT1 = [alphabet(14:26)]; %the first row is just the second half of the 
%alphabet, in order
for k = 2:13
    MAT1 = [MAT1 ; [MAT1((k-1),2:13) MAT1((k-1),1)]];
    %for every row after that, you just have to add the next row beneath
    %the rows that you have, and the next row is just the row before, only
    %you take the 2nd through 13th elements first, and then tack the 1st
    %element onto the end.
end
%the second matrix is made pretty much like the first, just backwards
MAT2 = [alphabet(1:13)];
for k = 2:13
    MAT2 = [MAT2 ; [MAT2((k-1),13) MAT2((k-1),1:12)]];
end
MAT = [MAT1 MAT2]; 
% create number vectors for the key and SM---------------------------------
SMN = []; %SMN stands for 'secret message in numbers' 
lth = length(SM); %this just needs updated because I've changed the length 
%of the message when I deleted the spaces and special characters
for m = 1:lth 
    for a = 1:26
        if SM(m) == alphabet(a) %if the letter of the message = a letter of the alphabet
            SMN = [SMN a]; %then take the number that represents what letter it is and add
            %it to this vector (so if the letter was D it would store 4
            %because D is the fourth letter of the alphabet)
        end
    end
end
KEYN = []; %this is goung to be the key in numbers, which is really just the
%number of the row of the encryption table that the letter of the key
%corresponds to.
lthk = length(KEY); %really I could just do the length of the SM here because
% I literally just made the key the length of the SM but this helps me
% remember we're working with the key here
for m = 1:lthk
    for a = 1:26
        if KEY(m) == alphabet(a)
            KEYN = [KEYN ceil(a/2)]; % this accounts for the fact that
            % every row in the matrix is assigned 2 key letters
        end
    end
end
% actual encypher/decypher-------------------------------------------------
%all that has to be done now is just to look at the row of the key letter and
%the column of the secret message and then take the letter of the table
%where those two match up
for k = 1:lth
    SM(k) = MAT(KEYN(k),SMN(k)); 
end

% fprintf the result-------------------------------------------------------
if EoD == 1
    fprintf('The encrypted message reads: \n"%s"\n',SM')
else
    fprintf('The decrypted message reads: \n"%s"\n',SM')
end
