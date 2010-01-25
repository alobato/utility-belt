require 'benchmark'

def quick(repetitions=100, &block)
  Benchmark.bm do |b|
    b.report {repetitions.times &block}
  end
  nil
end