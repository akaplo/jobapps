class ApplicationTemplate < ActiveRecord::Base
  has_many :response_fields

  DEPARTMENTS = %w(Bus
                   Special\ Transportation)

  validates :department, presence: true,
                         inclusion: {in: DEPARTMENTS}
end
