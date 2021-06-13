class CatRentals < ApplicationRecord

  STATUS = ['PENDING','APPROVED','DENIED']

  attribute :status, :string, default: 'PENDING'

  validates :status, presence: true, inclusion: {in: STATUS}

  validate :does_not_overlap_approved_request

  belongs_to:cat,
  class_name: "Cats",
  primary_key: :id,
  foreign_key: :cat_id

  def overlap
    @cats = CatRentals
    .where(cat_id:self.cat_id)
    .where("start < ? OR 'end' > ?", self.start,self.end)
    .where.not(id:self.id)
  end

  def approved_overlap
    @approved = overlap.where(status:'APPROVED')
  end

  def pending_overlap
    @pending = overlap.where(status:'PENDING')
  end

  def denied?
    self.status == 'DENIED'
  end

  def approve!
    transaction do
    self.status = "APPROVED"
    self.save!

    pending_overlap.each do |rental|
      rental.update!(status: 'DENIED')
      end
    end
  end

  def does_not_overlap_approved_request

    if self.denied?
      return
    end

    unless approved_overlap.empty?
      errors[:base] <<
        'Request conflicts with existing approved request'
    end
  end
end
