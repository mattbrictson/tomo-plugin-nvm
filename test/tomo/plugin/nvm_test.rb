class Tomo::Plugin::NvmTest < Tomo::Plugin::Nvm::Test
  def test_that_it_has_a_version_number
    refute_nil ::Tomo::Plugin::Nvm::VERSION
  end
end
