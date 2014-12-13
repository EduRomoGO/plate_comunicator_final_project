class User < ActiveRecord::Base
	has_many :issues
	has_many :issues_targeted, class_name: "Issue", foreign_key: "target_user_id"

	#plates regexpresions
		#before 1971: letter + 7 numbers
		#from 1971 to 2000: 1 or 2 letters + 4 numbers + 2 letters
		#from 2000: 4 numbers +3 letters
	#identification_number
		#nie: letter (x,y,z) + 7 numbers + any letter
		#nif: 8 numbers + any letter

  devise :database_authenticatable, :registerable,
				 :recoverable, :rememberable, :trackable, :validatable

	

	NATIONAL_DOCUMENT = "nif"
	#FOREIGNER_DOCUMENT = "nie"

	regexp_list = {
		:nif_number 			=> /\A(\d{8})([-]?)([A-Z]{1})\z/,
		:nie_number				=> /\A([x-zX-Z]{1})([-]?)(\d{7})([-]?)([a-zA-Z]{1})\z/,
		:nif_type				=> /\A[n][i][f]\z/,
		:nie_type				=> /\A[n][i][e]\z/,
		:plate_before_1971	=> /\A([a-zA-Z]{1})([-]?)([\d]{7,7})\z/,
		:plate_from_71_to_00	=> /\A([a-zA-Z]{1,2})([-]?)([\d]{4,4})([-]?)([a-zA-Z]{2,2})\z/,
		:plate_from_2000 		=> /\A([\d]{4,4})([a-zA-Z]{3,3})\z/}

	validates :identification_type, {presence: true}
	validates :identification_number, {
		presence: true,
		format: {with: regexp_list[:nif_number]}, if: :is_NATIONAL_DOCUMENT?}

	validates :identification_number, 
		format: {with: regexp_list[:nie_number]}, unless: :is_NATIONAL_DOCUMENT?
	
	validates :extra_plates, inclusion: { in: [true, false] }	
	validates :plate, {presence: true}

	def is_NATIONAL_DOCUMENT?
	 identification_type == NATIONAL_DOCUMENT
	end

end