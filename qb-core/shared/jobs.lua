QBShared = QBShared or {}
QBShared.ForceJobDefaultDutyAtLogin = true 
QBShared.Jobs = {
	unemployed = { label = 'Civilian', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Freelancer', payment = 10 } } },
	admin = { label = 'Admin Job', type = 'admin', defaultDuty = true, offDutyPay = false, grades = { ['0'] = { name = 'Sales', payment = 5000 } } },
	police = {
		label = 'Law Enforcement',
		type = 'leo',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'ACADEMY STUDENT', payment = 0 },
			['1'] = { name = 'CADET', payment = 0 },
			['2'] = { name = 'OFFICER I', payment = 0 },
			['3'] = { name = 'OFFICER II', payment = 0 },
			['4'] = { name = 'SENIOR OFFICER',  payment = 0},
			['5'] = { name = 'SENIOR LEAD OFFICER',  payment = 0 },
			['6'] = { name = 'SERGEANT I',  payment = 0 },
			['7'] = { name = 'SERGEANT II',  payment = 0 },
			['8'] = { name = 'LIEUTENANT I',  payment = 0 },
			['9'] = { name = 'LIEUTENANT II',  payment =0 },
			['10'] = { name = 'CAPTAIN',  payment = 2500 },
			['11'] = { name = 'MAJOR', isboss = true, payment = 0 },
			['12'] = { name = 'COLONEL', isboss = true, payment = 0 },
			['13'] = { name = 'COMMANDER', isboss = true, payment = 0 },
			['14'] = { name = 'DEPUTY CHIEF', isboss = true, payment = 0 },
			['15'] = { name = 'ASSISTANT CHIEF', isboss = true, payment = 0 },
			['16'] = { name = 'CHIEF OF POLICE', isboss = true, payment = 0 },
			['17'] = { name = 'MINISTER', isboss = true, payment = 0 },
		},
	},
	sheriff = {
		label = 'Law Enforcement',
		type = 'leo',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Academy Student', payment = 75 },
			['1'] = { name = 'Solo Cadet ', payment = 100 },
			['2'] = { name = 'Deputy', payment = 200 },
			['3'] = { name = 'Snr Deputy', payment = 250 },
			['4'] = { name = 'Corporal',  payment = 300 },
			['5'] = { name = 'Sergeant',  payment = 350 },
			['6'] = { name = 'Lieutnant',  payment = 700 },
			['7'] = { name = 'Capitain',  payment = 1000 },
			['8'] = { name = 'Ass Sheriff',isboss = true,  payment = 2000 },
			['9'] = { name = 'Sheriff', isboss = true,  payment = 3000 },

		},
	},
	['casino'] = {
        label = 'Casino',
        defaultDuty = true,
        grades = {
            ['0'] = { name = 'Novice', payment = 5000 },
            ['1'] = { name = 'Experienced', payment = 5000 },
            ['2'] = { name = 'Boss', isboss = true, payment = 8000 },
        },
    },

	['pizzathis'] = {
		label = 'Pizza This',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Novice', payment = 75 },
			['2'] = { name = 'Experienced', payment = 100 },
			['3'] = { name = 'Advanced', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
        },
	},
    ['uwu'] = {
		label = 'UwU Cat Cafe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Novice',
                payment = 50
            },
			['1'] = {
                name = 'Employee',
                payment = 100
            },
			['2'] = {
                name = 'Experienced',
                payment = 150
            },
			['3'] = {
                name = 'Advanced',
                payment = 200
            },
			['4'] = {
                name = 'Boss',
				isboss = true,
                payment = 250
            },
        },
	},
	['bean'] = {
		label = 'Bean Machine',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Novice',
                payment = 100
            },
			['1'] = {
                name = 'Employee',
                payment = 120
            },
			['2'] = {
                name = 'Experienced',
                payment = 130
            },
			['3'] = {
                name = 'Advanced',
                payment = 135
            },
			['4'] = {
                name = 'Boss',
				isboss = true,
                payment = 150
            },
        },
	},
	['ambulance'] = {
		label = 'EMS',
		type = 'ems',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'RECRUIT', payment = 0 },
			['1'] = { name = 'PARAMEDIC', payment = 0 },
			['2'] = { name = 'SENIOR PARAMEDIC', payment = 0 },
			['3'] = { name = 'SUPERVISOR', payment = 0 },
			['4'] = { name = 'NURSE', payment = 0 },
			['5'] = { name = 'DOCTOR', payment = 0 },
			['6'] = { name = 'PSYCHOLOGIST', payment = 0 },
			['7'] = { name = 'SURGEANT', payment = 0 },
			['8'] = { name = 'CAPTAIN', payment = 0 },
			['9'] = { name = 'ASSISTANT CHIEF', payment = 0 },
			['10'] = { name = 'CHIEF', isboss = true, payment = 0 },
			['11'] = { name = 'MINISTER OF HEALTH (DIRECTOR)', isboss = true, payment = 0 },
		},
	},
	realestate = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'House Sales', payment = 75 },
			['2'] = { name = 'Business Sales', payment = 100 },
			['3'] = { name = 'Broker', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	taxi = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 500 },
			['1'] = { name = 'Driver', payment = 800 },
			['2'] = { name = 'Event Driver', payment = 1000 },
			['3'] = { name = 'Sales', payment = 1500 },
			['4'] = { name = 'Manager', isboss = true, payment = 2000 },
		},
	},
	cardealer = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 50 },
			['1'] = { name = 'Showroom Sales', payment = 75 },
			['2'] = { name = 'Business Sales', payment = 100 },
			['3'] = { name = 'Finance', payment = 125 },
			['4'] = { name = 'Manager', isboss = true, payment = 150 },
		},
	},
	mechanic = {
		label = 'LS Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 700 },
			['1'] = { name = 'Novice', payment = 1000 },
			['2'] = { name = 'Experienced', payment = 1300 },
			['3'] = { name = 'Advanced', payment = 1700 },
			['4'] = { name = 'Manager', isboss = true, payment = 2000 },
		},
	},
	 ['bahamas'] = {
		label = 'Bahamas Unicorn',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 100 },
			['1'] = { name = 'Novice', payment = 150 },
			['2'] = { name = 'Experienced', payment = 200 },
			['3'] = { name = 'Advanced', payment = 300 },
			['4'] = { name = 'Manager', isboss = true, payment = 500 },
        },
	},
	['auction'] = {
		label = 'Auction',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
        ['0'] = { name = 'Car auction manager',payment = 1000,isboss = true },
	    },
	},	

}
