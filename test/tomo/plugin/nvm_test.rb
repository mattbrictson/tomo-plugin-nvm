require "test_helper"

class Tomo::Plugin::NvmTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Tomo::Plugin::Nvm::VERSION
  end
end
