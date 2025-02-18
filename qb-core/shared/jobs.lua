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
			['0'] = { name = 'Rockie', payment = 0 },
			['1'] = { name = 'OFFICER I', payment = 0 },
			['2'] = { name = 'OFFICER II', payment = 0 },
			['3'] = { name = 'SENIOR OFFICER',  payment = 0},
			['4'] = { name = 'SENIOR LEAD OFFICER',  payment = 0 },
			['5'] = { name = 'SERGEANT I',  payment = 0 },
			['6'] = { name = 'SERGEANT II',  payment = 0 },
			['7'] = { name = 'LIEUTENANT I' isboss = true,  payment = 0 },
			['8'] = { name = 'LIEUTENANT II' isboss = true,  payment =0 },
			['9'] = { name = 'CAPTAIN' isboss = true,  payment = 0 },
			['10'] = { name = 'MAJOR', isboss = true, payment = 0 },
			['11'] = { name = 'COLONEL', isboss = true, payment = 0 },
			['12'] = { name = 'COMMANDER', isboss = true, payment = 0 },
			['13'] = { name = 'DEPUTY CHIEF', isboss = true, payment = 0 },
			['14'] = { name = 'ASSISTANT CHIEF', isboss = true, payment = 0 },
			['15'] = { name = 'CHIEF OF POLICE', isboss = true, payment = 0 },
		},
	},
	sheriff = {
		label = 'Law Enforcement',
		type = 'leo',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'deputy', payment = 0 },
			['1'] = { name = 'corporal', payment = 0 },
			['2'] = { name = 'invertigator', payment = 0 },
			['3'] = { name = 'master invertigator', payment = 0 },
			['4'] = { name = 'Deputy Sheriff', payment = 0 },
			['5'] = { name = 'Sergeant', payment = 0 },
			['6'] = { name = 'Lieutenant',  payment = 0 },
			['7'] = { name = 'Captain' isboss = true,  payment = 0 },
			['8'] = { name = 'Chief Deputy' isboss = true,  payment = 0 },
			['9'] = { name = 'assistant sheriff' isboss = true,  payment = 0 },
			['10'] = { name = 'Undersheriff',isboss = true,  payment = 0 },
			['11'] = { name = 'Sheriff', isboss = true,  payment = 0 },
		},
	},
	justice = {
		label = 'Law Enforcement',
		type = 'leo',
		defaultDuty = false,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Prosecution', payment = 0 },
			['1'] = { name = 'Lawyer', payment = 0 },
			['2'] = { name = 'judge', payment = 0 },
		},
	},
	['casino'] = {
        label = 'Casino',
        defaultDuty = true,
        grades = {
            ['0'] = { name = 'Novice', payment = 0 },
            ['1'] = { name = 'Experienced', payment = 0 },
            ['2'] = { name = 'Boss', isboss = true, payment = 0 },
        },
    },

	['pizzathis'] = {
		label = 'Pizza This',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 0 },
			['1'] = { name = 'Novice', payment = 0 },
			['2'] = { name = 'Experienced', payment = 0 },
			['3'] = { name = 'Advanced', payment = 0 },
			['4'] = { name = 'Manager', isboss = true, payment = 0 },
        },
	},
    ['uwu'] = {
		label = 'UwU Cat Cafe',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = {
                name = 'Novice',
                payment = 0
            },
			['1'] = {
                name = 'Employee',
                payment = 0
            },
			['2'] = {
                name = 'Experienced',
                payment = 0
            },
			['3'] = {
                name = 'Advanced',
                payment = 0
            },
			['4'] = {
                name = 'Boss',
				isboss = true,
                payment = 0
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
                payment = 0
            },
			['1'] = {
                name = 'Employee',
                payment = 0
            },
			['2'] = {
                name = 'Experienced',
                payment = 0
            },
			['3'] = {
                name = 'Advanced',
                payment = 0
            },
			['4'] = {
                name = 'Boss',
				isboss = true,
                payment = 0
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
			['9'] = { name = 'ASSISTANT CHIEF' isboss = true, payment = 0 },
			['10'] = { name = 'CHIEF', isboss = true, payment = 0 },
		},
	},
	realestate = {
		label = 'Real Estate',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 0 },
			['1'] = { name = 'House Sales', payment = 0 },
			['2'] = { name = 'Business Sales', payment = 0 },
			['3'] = { name = 'Broker', payment = 0 },
			['4'] = { name = 'Manager', isboss = true, payment = 0 },
		},
	},
	taxi = {
		label = 'Taxi',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 0 },
			['1'] = { name = 'Driver', payment = 0 },
			['2'] = { name = 'Event Driver', payment = 0 },
			['3'] = { name = 'Sales', payment = 0 },
			['4'] = { name = 'Manager', isboss = true, payment = 0 },
		},
	},
	cardealer = {
		label = 'Vehicle Dealer',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 0 },
			['1'] = { name = 'Showroom Sales', payment = 0 },
			['2'] = { name = 'Business Sales', payment = 0 },
			['3'] = { name = 'Finance', payment = 0 },
			['4'] = { name = 'Manager', isboss = true, payment = 0 },
		},
	},
	mechanic = {
		label = 'LS Customs',
		type = 'mechanic',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
			['0'] = { name = 'Recruit', payment = 0 },
			['1'] = { name = 'Novice', payment = 0 },
			['2'] = { name = 'Experienced', payment = 0 },
			['3'] = { name = 'Advanced', payment = 0 },
			['4'] = { name = 'Manager', isboss = true, payment = 0 },
		},
	},
	 ['bahamas'] = {
		label = 'Bahamas Unicorn',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
            ['0'] = { name = 'Recruit', payment = 0 },
			['1'] = { name = 'Novice', payment = 0 },
			['2'] = { name = 'Experienced', payment = 0 },
			['3'] = { name = 'Advanced', payment = 0 },
			['4'] = { name = 'Manager', isboss = true, payment = 0 },
        },
	},
	['auction'] = {
		label = 'Auction',
		defaultDuty = true,
		offDutyPay = false,
		grades = {
        ['0'] = { name = 'Car auction manager',payment = 0,isboss = true },
	    },
	},	

}
