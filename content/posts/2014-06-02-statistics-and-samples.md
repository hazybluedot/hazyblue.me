---
title: Samples, Statistics, Central Limit Theorem, oh my!
subtitle: A deeper look at the 'Central Limit Theorem' final project, and what some typical uses of a statistical tool might be
kind: article
published: true
created_at: '2014-06-02 18:38:00 -0400'
author_name: Darren Maczka
tags: programming, statistics
---

Continuing the theme from [last time], I'd like to take a closer look
at another final project from this past semester's ECE2524. Just like
the project I reviewed last time, the
[central limit theorem calculator][original] works as advertised, but
it requires quite a bit of interactivity which makes it difficult to
use in a script. Providing a good non-interactive interface is
particularly important for this project: one of the assumptions needed
to use the results of the [central limit theorem][clt] (CLT) is that
the sample size is greater than 30 or 40. Depending on the data, a
sample could contain hundreds of measurements and the current
program prompts the user for every single one.

[last time]: /2014/05/decreas-complexity-increase-usability/

<!-- more -->

Oh, statistics. Notorious for adding confusion and frustration to the
lives of many a college student, I want to first praise the decision
to focus a final project on a topic like the
[Central Limit Theorem][clt]. Writing a program to solve a problem is
a great way to gain a better understanding of a new and complex
problem space, while at the same time providing practice in the
technical skills and tools to solve it.

([Central Limit Theorem]
  - Definition: [stattrak][clt], [wikipedia][wiki:clt]
  - [Learn with Khan Academy][khan:clt]
  - [Experiment][cltdemo]
)

Quickly summarized, the CLT states that under certain conditions,
statistics generated from samples taken of an arbitrary population can
be assumed to be taken from a [Normal][Gaussian] ([Gaussian])
distribution. This is a powerful theorem:

1. many populations we are interested in are not best represented as a
   Normal distribution, and what's more, the true population
   distribution is often unknown.
2. A lot of mathematical theory and tools exist to work with
   statistics of Normal distributions.

When we are working with a data sample, we are often concerned with
out well the sampled data represents the population which we are
interested in. A [confidence interval] is used to express the degree of
uncertainty (conversely, confidence) that a sample statistic is good
estimate of a population parameter.

## The Code

The original [implementation depends][original] on quite a few prompts
for data making the program difficult to use in a script.  Instead of
interactive prompts, Unix developers favor command line options as a
means of supplying initial parameters to a program. Currently the
program prompts for:

- sample size
- each data point
- standard deviation
- a confidence level

From this the program computes and displays the confidence interval
calculated from the given data.

First, note that some of the data requested from the user is redundant:

- the sample size is a function of the data set
- the standard deviation is a function of the data set

If the program expects to read one sample per line of input, the
number of input lines *is* the sample size, so we shouldn't prompt the
user for that information.  The standard deviation of the sample can
be easily calculated from the data as well, so we don't need to prompt
for that. Finally, as I mentioned, it is limiting to expect a user to
manually enter data samples, often will be interested in running
calculations on many samples, each with potentially hundreds or even
thousands of data points. This data will often be coming from another
file, or another program.  If we modify our program to read data
samples from *standard input* we can easily read data from just about
any source.

Let's convert the `void addSampleData(vetor<double> &sample, int
sampleSize)` function to `vector<double> readSamples(istream
&is)`. I'll put this code in a file named `sample.cpp` and create a
corresponding file `sample.hpp` with the function declaration.

([move semantics] Don't worry about returning an object from the function like this,
with [C++11 move semantics] the data isn't copied, instead the
ownership of the object is transferred from the function to the
caller.)

~~~~ c
/* sample.cpp */
#include <iostream>
#include <vector>

using namespace std;

vector<double> readSample(istream& is) {
    vector<double> samples;
    string line;
    char *endptr;

    while (getline(is, line)) {
        double s;
        s = strtod(line.c_str(), &endptr);
        samples.push_back(s);
    }
    return samples;
}
~~~~

Note, I've left out error checking around [`strtod`][strtod] for
clarity. Conveniently, we never have to deal with an explicit 'size'
variable, when we need the sample size we'll just call
[std::vector::size].  Because our function takes a reference to an
[istream][std::istream] as an argument it will happily read in data
from any source that can be made to look like an input stream, whether
it be from standard input, a file provided on the command line, or
even a network socket.  A simple program that just reads in samples
from standard input might look like

~~~ cpp
#include <iostream>
#include <algorithm>
#include <vector>

#include "sample.hpp"

using namespace std;

int main(int argc, char* argv[]) {
    std::vector<double> sample;
    double mean, var;

    sample = readSample(std::cin);

    mean = accumulate(sample.begin(), sample.end(), 0.0) / sample.size();
    
    vector<double> res(sample.size());
    transform(sample.begin(), sample.end(), res.begin(), [mean](double d) { return (d-mean)*(d-mean); } );
    
    var = accumulate(res.begin(), res.end(), 0.0) / (sample.size()-1);

    cout << mean << ", " << var << endl;

    return EXIT_SUCCESS;
}
~~~

Notice the use of [`accumulate`][std::accumulate] and
[`transform`][std::transform] provided by [`<numeric>`][std::numeric]
and [`<algorithm>`][std::algorithm]. Since computing the arithmetic
mean and variance are common calculations, we might want to break
these out into functions.  While we are using a `std::vector<double>`
to represent a sample, we want to impose as few assumptions as
possible on input data for our functions, they should operate on
anything that can be iterated over, so we'll follow the same structure
used by functions provided by `<algorithm>' and accept templated
iterators as arguments.

~~~ cpp
/* stat.hpp */
#ifndef _STAT_HPP_
#define _STAT_HPP_

#include <algorithm>
#include <numeric>

namespace stat {
    template<typename InputIterator>
    double mean(InputIterator first, InputIterator last) {
        return std::accumulate(first, last, 0.0) / distance(first, last);
    }

    template<typename InputIterator>
    double variance(InputIterator first, InputIterator last, double mu, int bias=1) {
        std::vector<double> res(std::distance(first, last));
        
        std::transform(first, last, [mu](double d) { return (d-mu)*(d-mu); });

        return std::accumulate(res.begin(), res.end(), 0.0) / (distance(first, last) - bias);
    }
}

#endif
~~~

The `int bias` argument is used to provide flexibility to use our
function to compute both [population variance] (`bias=0`) and [sample
variance] (`bias=1`).

Now that we have nice, modular and orthogonal functions to calculate
mean and variance, what might we want a program that reads in samples
to do with them?

## Confidence Intervals

Watch [Confidence intervals][khan:Confidence intervals] on
[Khan Academy] and see [What is a Confidence Interval?] for an
understanding of what a confidence interval means.

To compute a confidence interval of a statistic (e.g. mean) we need

- the statistic itself
- the [standard error]
- the [critical value]

We can then calculate the [margin of error] and finally the
[confidence interval].

([symbols]
$$\mu$$
: population mean

$$\sigma$$
: population standard deviation

$$\bar{x}$$
: sample estimate of $$\mu$$

$$s$$
: [sample estimate of $$\sigma$$][wiki:unbiased_estimate_of_standard_deviation]

$$n$$
: sample size
)

If we want the confidence interval of the mean, then our statistic is
the mean, which our program already calculates from the sample
data. The standard error is

\\[ SE = s/\sqrt(n) \\]

Where $$s$$ is the
[sample estimate of $$\sigma$$][wiki:unbiased_estimate_of_standard_deviation]
which our program already calculates in the form of the variance with
`stat::variance` setting `bias=1`

A nearly complete program to calculate a confidence interval of a
sample might look like

~~~ c
#include "stat.hpp"

int main(int argc, char *argv[]) {
    vector<double> sample;
    double smean, svar, cstdev, cval;
    char* endptr;
    cval = NAN;
    int opt, ssize;

    cval = NAN; /* TODO: calculate critical value */

    sample = readSample(cin);
    ssize = sample.size();

    smean = stat::mean(sample.begin(), sample.end());
    /* With default delim=1 this calculates the best
     * estimate of the sample distribution variance given
     * this sample */
    svar = stat::variance(sample.begin(), sample.end(), smean);

    /* standard error */
    cstdev = sqrt(svar/ssize);

    /* margin of error = critical value * standard error */
    double merror = cval * cstdev;

    /* confidence interval = sample statistic ± Margin of error */
    cout << smean << "\t" << merror << "\t" << smean-merror << "\t" << smean+merror << endl;

}
~~~

We use our `readSample()` to read a list of sample data from standard
input, from this we also get the sample size.  Our two `stat::`
functions take care of calculating the sample statistics and the
standard error is just a simple calculation from these values.

But how do we find the criticle value, `cval`? For an integer
confidence level $$c$$, the critical value is x such that

\\[ CDF(x) = .5 - \alpha/2 \\]

Where $$\alpha = c/100$$ and $$CDF(x)$$ is the cumulative distribution
function for the sample distribution, which due to the central limit
theorem we can assume to be Normal.  Unfortunately, solving for 'x'
isn't straightforward, which is why in practice we just use a look-up
table (of course, the numbers in the table have to come from
somewhere, but we'll come back to that later).  Just like for the
[resistor color code calculator], it makes a lot of sense to create a
look-up table in the code.  Not only does this increase transparency,
it puts all the data in one, easy to varify and modify place.  If the
assumptions behind the central limit theorem are met, and our sample
size is greater than 30, we can assume our sampling distribution is
normal and use a z-table to look up our critical values.

([small sample size] If our sample size is less than 30 our sample
statistics are best modeled coming from a
[Student's-t distribution][wiki:studentstdist] and we would need to
use a [t-table][wiki:t-table] instead )

~~~ c
#include <cmath>

typedef struct {
    /* because checking floating point equality is tricky, store the
     * confidence as int(confidence_percent*100) */
    int conf;
    double zval;
} ztable_entry;

static ztable_entry z_table[] = {
    { 99, 2.58  },
    { 98, 2.33  },
    { 95, 1.96  },
    { 90, 1.645 },
};

#define Z_TABLE_LEN  sizeof(z_table)/sizeof(z_table[0])

/* return the critical value for a given confidence interval */
/* If `conf` is not found in the table, NaN is returned */
double critval(int conf) {
    for(size_t i=0; i < Z_TABLE_LEN; ++i) {
        if (z_table[i].conf == conf) {
            return z_table[i].zval;
        }
    }
    return NAN;
}
~~~

The remaining piece of our program is to somehow get the desired
confidence level from the user. In the [original project][original]
the program prompted the user interactively.  While this works and is
user-friendly, it isn't scripting friendly, and considering you will
probably want to do something with the interval once you have it, and
that the sample data could very well be coming from another program,
we want this to be as scriptable as possible, so we'll follow the Unix
convention and get the confidence level from a command line parameter,
using `getopt` to handle option parsing. I won't go into details of
using `getopt` here, inspect the source for details.

Now we can use our program to calculate confidence intervals for
various data sets. I generated some example data based on
[Problem 1 on the stattrek confidence interval page][stattrek:problem1] in a file named
`weight_data`

~~~~ console
$ ./stats < weight_data
180, 29.2793
$ ./cint -c 95% < weight_data
180     1.81475 178.185 181.815
~~~~

The output data contains tab delineated values of the sample mean, the
margin of error, and then the sample mean ± the margin of error.  The
results closely match those given at stattrek (note that the sample
data doesn't have exactly the same statistics as those used in the
sample problem!)

My modified code is available on [GitHub](https://github.com/hazybluedot/UnixGroupProject).

[stattrek:problem1]: http://stattrek.com/estimation/confidence-interval.aspx?Tutorial=AP
[C++11 move semantics]: http://www.cprogramming.com/c++11/rvalue-references-and-move-semantics-in-c++11.html
[Gaussian]: http://en.wikipedia.org/wiki/Normal_distribution
[Khan Academy]: https://www.khanacademy.org
[Z-test]: http://en.wikipedia.org/wiki/Z-test
[clt]: http://stattrek.com/statistics/dictionary.aspx?definition=central_limit_theorem
[cltdemo]: http://onlinestatbook.com/stat_sim/sampling_dist/index.html
[khan:CLT]: https://www.khanacademy.org/math/probability/statistics-inferential/sampling_distribution/v/central-limit-theorem
[khan:Confidence intervals]: https://www.khanacademy.org/math/probability/statistics-inferential/confidence-intervals/v/confidence-interval-1
[khan:clt]: https://www.khanacademy.org/math/probability/statistics-inferential/sampling_distribution/v/central-limit-theorem
[margin of error]: http://stattrek.com/estimation/margin-of-error.aspx?Tutorial=Stat
[one-sample location test]: http://en.wikipedia.org/wiki/Location_test
[original]: https://github.com/nukdae/unixgroupproject
[population variance]: http://en.wikipedia.org/wiki/Variance#Population_variance
[resistor color code calculator]: https://github.com/dhonig26/ECE_2500_Final_Project
[sample variance]: http://en.wikipedia.org/wiki/Variance#Sample_variance
[standard error]: http://stattrek.com/estimation/standard-error.aspx
[standard error]: http://stattrek.com/estimation/standard-error.aspx?Tutorial=Stat
[std::accumulate]: http://www.cplusplus.com/reference/numeric/accumulate/
[std::algorithm]: http://www.cplusplus.com/reference/algorithm/
[std::istream]: http://www.cplusplus.com/reference/istream/istream/
[std::numeric]: http://www.cplusplus.com/reference/numeric/
[std::transform]: http://www.cplusplus.com/reference/algorithm/transform/
[std::vector::size]: http://www.cplusplus.com/reference/vector/vector/size/
[strtod]: http://pubs.opengroup.org/onlinepubs/007904975/functions/strtod.html
[wiki:CLT]: http://en.wikipedia.org/wiki/Normal_distribution#The_central_limit_theorem
[wiki:studentstdist]: http://en.wikipedia.org/wiki/Student%27s_t-distribution
[wiki:t-table]: http://en.wikipedia.org/wiki/Student%27s_t-distribution#Table_of_selected_values
[wiki:unbiased_estimate_of_standard_deviation]: http://en.wikipedia.org/wiki/Unbiased_estimation_of_standard_deviation
[z-score]: http://stattrek.com/statistics/dictionary.aspx?definition=z_score
