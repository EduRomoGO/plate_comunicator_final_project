

for i in 1..2
	u = User.create identification_type: "dni", identification_number: "#{i}2345678L", extra_plates: false, plate: "#{i}234AIZ"
	unless u.errors.empty?
		u.errors.full_messages
	end
end

for i in 1..2
	y = User.create identification_type: "nie", identification_number: "X#{i}234567L", extra_plates: false, plate: "#{i}234AIZ"
	unless y.errors.empty?
		y.errors.full_messages
	end
end

#user = User.find_by(identification_number: "12345678L")
#user.panel_messages.create text: "i will be back in 10 minutes"
#user.panel_messages.create text: "i am in bar Manolo"

#user2 = User.find_by(identification_number: "X2234567L")
#user2.panelMessages.create text: "sorry this is an emergency"