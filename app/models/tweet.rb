class Tweet < ApplicationRecord
	belongs_to :user

	MIN_LIST_COUNT = 1
	MAX_LIST_COUNT = 100

  DEFAULT_LIST_COUNT = 10

	scope :with_search_options, -> (options) {
		relation = offset(options[:offset]).limit(options[:limit])
		relation = relation.where(user_id: options[:user_id]) if options[:user_id].present?
		relation = relation.where('created_at <= ?', Time.at(options[:time])) if options[:time].present?
		relation.order(created_at: :desc, id: :desc)
	}

	def self.search(options)
		options[:offset] = 0 if options[:offset].blank?
		options[:limit] = [[options[:limit] || DEFAULT_LIST_COUNT, MIN_LIST_COUNT].max, MAX_LIST_COUNT].min

		with_search_options(options)
	end

end
