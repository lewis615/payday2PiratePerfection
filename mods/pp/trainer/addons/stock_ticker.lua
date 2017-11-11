-- Custom stock ticker...  now with Donations by Davy Jones
if TextTemplateBase then
	local ipairs = ipairs
	local pcall = pcall
	local tonumber = tonumber
	local tostring = tostring
	local type = type

	local rand = math.rand

	local s_find = string.find
	local s_format = string.format
	local s_gsub = string.gsub
	local s_reverse = string.reverse
	local s_split = string.split
	local s_sub = string.sub

	local t_insert = table.insert

	local Steam = Steam

	local function format_dec(input)
		if input == "--" then
			return input
		end
		local _, _, minus, int, dec = s_find(tostring(input), '([-]?)(%d+)([.]?%d*)')
		int = s_gsub(s_reverse(int), "(%d%d%d)", "%1,")
		return minus..s_gsub(s_reverse(int), "^,", "")..dec
	end

	function TextTemplateBase:_stock_ticker()
		for i = 1, self._unit:text_gui().ROWS do
			self._unit:text_gui():set_row_gap(i, 20)
			self._unit:text_gui():clear_row_and_guis(i)
			self._unit:text_gui():set_row_speed(i, i * 100)
		end
		local companies = {
			"[TEC] E-peen",
			"247 Kick You One Time",
			{"A-Fancy-Domain-Of-My-Choice.com", true},
			"Analtech",
			"Assmans Barber",
			"B.J. Cummings Co.",
			"Bass Drop Movers",
			"Beaver Cleaners",
			"Beaver Research",
			"Bimbo Bakeries",
			"Blaxican Fried Burritos Inc.",
			{"Blood-Island.com", true},
			"Butamax",
			"Camel Towing",
			"Cash 22 Pawnbroker",
			"Choosespain",
			"Come On Baby",
			{"CopyCat Coders Co.", false},
			"Couche Tard",
			"Curl Up and Dye",
			"Cyberdyne Systems",
			"Deja Brew",
			"Dingleberrys",
			"Doge Style Pedigree",
			{"Donations Director", true},
			"Dongs",
			"Florist Gump",
			"Fuk Mi Sushi Bar",
			"Get Serious",
			"Hand Jobs, Nails and Spa",
			{"Harfatus Engineering Ltd.", true},
			"Harry Butz Day Spa",
			"Hash House A Go Go",
			"Hooker Cockram Inc.",
			"Hooker Furniture",
			"Houdini Hats",
			"HoxHud.com",
			"I.C. Wiener Enterprises",
			"Infamy Lingeri",
			"iPoo",
			"Juan In A Million",
			"Kidsexchange",
			"Kum and Go",
			"Kuntz Insurance Group",
			"Last Bullet Gaming",
			"Lawn And Order",
			"Lewd Leather",
			"Lick-a-Chick",
			"Lord Of The Fries",
			"Master Bait and Tackle",
			"Masters Brawlers",
			"Masters Virtual Wonders",
			"Merry Widow Life Insurance",
			"Our Motherboard of Mercy",
			"Over9000 Hypetrains",
			{"Parrotspeak.com", true},
			"Pen Island",
			"PHO Shizzle",
			{"PirateBiz", true},
			{"PirateNexus.com", true},
			{"PiratePerfection.com", true},
			"Planet Of The Grapes",
			"PocoCurante Infosystems",
			"Poo Ping Palace",
			"Pump 'n Munch",
			"Queef Perfumes",
			"RedNeck Perimeter Defence Corp.",
			"Sandy Balls Country Club",
			{"Simplity Mods", true},
			"Som Tang Wong Industries",
			{"South Andros", true},
			"Speedofart",
			"Spick and Span Window Cleaning",
			"Stiff Nipples Air Conditioning",
			"Stinky Stork Diaper Service",
			"Surelock Holmes",
			"TCN E-peen",
			"Tequila Mockingbird",
			"Thai Me Up",
			"The Daily Grind",
			"The Fryin Dutchman",
			"The Glory Hole",
			{"TheBloodyFAQ.com", true},
			{"ThePirateBay.org", true},
			"Threeway Express",
			{"Transcend Ltd.", true},
			{"unknownShits.me", false},
			"Unlimited Erections LLC.",
			"WE LOVE OVERKILL",
			"WhoRepresents.com",
			"Wok Around the Clock",
			"Wok This Way",
			"Wong, Doody, Crandall and Wiener",
			"Yahpoo Plumbing",
			"You Bed Your Life"
		}
		if not TextTemplateBase.STOCK_PERCENT then
			TextTemplateBase.STOCK_PERCENT = {}
			local bankruptcy_chance = rand(0.01)
			local bad_chance = rand(0.1)
			local good_chance = rand(0.1)
			local joker_chance = rand(0.01)
			local srand
			for i, company in ipairs(companies) do
				srand = 0
				if type(company) == "table" then
					if company[2] then
						srand = rand(100, 1000)
					else
						srand = rand(-1000, -500)
					end
				elseif bankruptcy_chance > rand(1) then
					srand = rand(-99, -45)
				elseif bad_chance > rand(1) then
					srand = rand(-55, -5)
				elseif good_chance > rand(1) then
					srand = rand(0, 40)
				elseif joker_chance > rand(1) then
					srand = rand(-100, 250)
				else
					srand = rand(-10, 10)
				end
				TextTemplateBase.STOCK_PERCENT[i] = srand
			end
		end
		for i, company in ipairs(companies) do
			local j = TextTemplateBase.STOCK_PERCENT[i]
			local row = math.mod(i, self._unit:text_gui().ROWS) + 1
			self._unit:text_gui():add_text(row, type(company) == "table" and company[1] or company, "white")
			self._unit:text_gui():add_text(row, "" .. (j < 0 and "" or "+") .. format_dec(s_format("%.2f", j)) .. "%", j < 0 and "light_red" or "light_green", self._unit:text_gui().FONT_SIZE / 1.5, "bottom", nil)
			self._unit:text_gui():add_text(row, "  ", "white")
		end
	end

	function TextTemplateBase:_big_bank_welcome()
		for i = 1, self._unit:text_gui().ROWS do
			self._unit:text_gui():clear_row_and_guis(i)
			self._unit:text_gui():set_row_gap(i, 50)
			self._unit:text_gui():set_row_speed(i, i * 200)
		end
		local function set_text(success, page)
			local texts = {}
			local texts2 = {}
			local function donation_display()
				page = s_split(s_gsub(s_gsub(s_gsub(s_gsub(s_gsub(page, "<.->", ""), "(.-)All Goals", "", 4), "Latest Goals(.*)", ""), "%$", ""), ",", ""), "\n")
				local sec_1 = "Latest Donations"
				local sec_2 = "Donations Director"
				local sec_3 = "Top Donors"
				local sec_4 = "View Top Donors"
				local sec_5 = "Donation Stats"
				local line = 1
				while page[line] ~= sec_1 do
					local title = page[line]
					while not s_find(page[line], " worth of booty collected") do
						line = line + 1
					end
					t_insert(texts, {title, s_gsub(page[line], " of(.*)", "")})
					line = line + 3
					if s_sub(page[line], 1, 8) == "IP.Board" then
						line = line + 1
					end
				end
				t_insert(texts2, sec_1)
				local function sec_2_check()
					while true do
						local text = page[line]
						if text == sec_2 then
							return false
						elseif s_sub(text, 1, 1) == " " and s_sub(text, -3, -3) == "." then
							return true
						else
							line = line + 1
						end
					end
				end
				while sec_2_check() do
					t_insert(texts2, {page[line - 1], s_gsub(page[line], " ", "")})
					line = line + 1
				end
				t_insert(texts2, sec_3)
				while page[line] ~= sec_3 do
					line = line + 1
				end
				line = line + 1
				while page[line] ~= sec_4 do
					t_insert(texts2, {page[line + 1], page[line]})
					line = line + 2
				end
				while page[line] ~= sec_5 do
					line = line + 1
				end
				t_insert(texts, {page[line + 1], page[line + 2]})
				t_insert(texts, {page[line + 5], page[line + 6]})
			end
			local use_default = true
			if success and s_find(s_sub(page, 0, 80), "All Goals") and pcall(donation_display) then
				use_default = false
			end
			if use_default then
				texts = {"We know how to hide your money", "Your money is our money", "Your money stays with us", "Give us your money right now", "Time to cash in?", "We love your money", "We suck for a buck", "Why so hilarious?", "A penny saved is still just a penny", "Robbing Joe Average since 1872", "Donate and get perks", "Why are you still reading this?", "Nothing to see here!", "Go on, rob the fuckers", "Dafuq did I just say, rob them already", "I give up, your too stubborn for me", "Now go rob the bank, ok?", "Thank you for your patience, We'll take your money now"}
				texts2 = {"Fencing", "Money Laundering", "Betting", "Pyramid Schemes", "Gold Bars", "No Questions Asked Deposits", "No Withdrawals", "Prostitution", "Scams", "VAT Carousels", "Creative Bookkeeping", "OCCUPY WALLSTREET"}
			end
			for _, text in ipairs(texts) do
				self._unit:text_gui():add_text(1, "    -    ", "green")
				self._unit:text_gui():add_text(1, "Welcome to the Blood Island Bank", "green")
				self._unit:text_gui():add_text(1, "    -    ", "green")
				self._unit:text_gui():add_text(1, use_default and text or text[1]..":", use_default and "green" or "orange")
				self._unit:text_gui():add_text(1, use_default and "" or "$"..format_dec(text[2]), "white")
			end
			for _, text in ipairs(texts2) do
				local t_type = type(text) == "table"
				if not t_type then
					self._unit:text_gui():add_text(2, "  -  ", "light_green")
				else
					self._unit:text_gui():add_text(2, "  ", "white")
				end
				self._unit:text_gui():add_text(2, (t_type and text[1] or text)..(use_default and "" or ":"), t_type and (text[2] == "--" and "white" or tonumber(text[2]) >= 25 and "yellow" or tonumber(text[2]) >= 5 and "red" or "light_blue") or "light_green")
				self._unit:text_gui():add_text(2, t_type and "$"..format_dec(text[2]) or "", "white")
			end
		end
		Steam:http_request("https://www.pirateperfection.com/donate/view-goals/", set_text)
	end
end