# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :name, presence: true, length: { minimum: 3 }
  validates :address, presence: true
  validates :description, presence: true
  validates :phone, presence: true, length: { minimum: 8 }, numericality: { only_integer: true }
  validates :gender, presence: true
  has_many :turnos
  has_many :resenas
end
