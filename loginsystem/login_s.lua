--// Script by PSWGM9100

Connection = dbConnect("mysql","dbname=test;host=localhost","root","")

function Register(player,cmd,pw)
	local pwCode = md5(pw);
	local db = dbQuery(Connection, "SELECT * FROM userdata WHERE name = '" .. getPlayerName(player) .. "' AND passwort = '" .. pwCode .. "'");
	local result, check = dbPoll(db, -1); -- check: 0 == vergeben; 1 == verfügbar
	
	if check == 0 then
		dbExec(Connection,"INSERT INTO userdata (name, passwort) VALUES ( '"..getPlayerName(player).."','"..pwCode.."')");
		outputChatBox("Erfolgreich registiert.",player,0,139,0);
	else
		outputChatBox("Registrierung fehlgeschlagen(Spielername bereits vorhanden).",player,139,0,0);
	end
end

function Login(player,cmd,pw)
	local Name = getPlayerName(player);
	local Pwunhash = md5(pw);
	local db = dbQuery(Connection, "SELECT * FROM userdata WHERE name = '" .. Name .. "' AND passwort = '" .. Pwunhash .. "'");
	local result, check = dbPoll(db, -1); -- check: 0 == vergeben; 1 == verfügbar
	
	if check == 1 then
		outputChatBox("Eingeloggt.",player,0,139,0);
	else
		outputChatBox("Passwort fehlerhaft.",player,139,0,0);
	end
end


addCommandHandler("rregister", Register)
addCommandHandler("llogin", Login)