require_relative '../../lib/reek/smells'
require_relative '../../lib/reek/smells/smell_detector'
require_relative '../../lib/reek/smells/smell_warning'

FactoryGirl.define do
  factory :context, class: Reek::Context::CodeContext do
    skip_create

    initialize_with do
      new(nil, nil)
    end
  end

  factory :smell_detector, class: Reek::Smells::SmellDetector do
    skip_create
    transient do
      smell_type 'FeatureEnvy'
    end
    source 'dummy_file'

    initialize_with do
      ::Reek::Smells.const_get(smell_type).new(source)
    end
  end

  factory :smell_warning, class: Reek::Smells::SmellWarning do
    skip_create
    smell_detector
    context 'self'
    source 'dummy_file'
    lines [42]
    message 'smell warning message'
    parameters { {} }

    initialize_with do
      new(smell_detector,
          source: source,
          context: context,
          lines: lines,
          message: message,
          parameters: parameters)
    end
  end
end
