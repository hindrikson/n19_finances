module BufferCategories
  CATEGORIES = %w[
    water_buffer
    electricity_buffer
    oil_buffer
    groceries_buffer
    reserve_buffer
    deposit_buffer
    remaining_buffer
  ].freeze
end

module TrackedBuffers
  TRACKED_BUFFERS = (BufferCategories::CATEGORIES - %w[remaining_buffer]).freeze
end
