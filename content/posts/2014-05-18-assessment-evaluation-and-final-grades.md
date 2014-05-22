---
title: Assessment, Evaluation, and Final Grades
published: true
kind: article
created_at: '2014-05-18 07:42:15 -0400'
author_name: hazybluedot
tags: assessment, evaluation, teaching, programming
---

I still feel like I'm recovering from the final couple weeks of the
semester, and I still have one more task to complete as part of my
teaching responsibilities before I *don't* take a break and roll right
in to finishing up a M.S. thesis. So the time is as good as any to
reflect on these past two weeks, and since these were my final last
two weeks teaching EC2524, maybe a chance to reflect on my experience
as a whole.

<!-- more -->

[TL;DR](#a-project-evaluation-method-with-a-focus-on-assessment)

Grading has always been hard for me. It is ridiculous to assume that a
single number can represent an individual's understanding of a topic
and I have a hard time doing things that I think are ridiculous. It
would be easier if so much weight wasn't placed on final grades.

Anyway, I'm in danger of veering off on a tyrant about grading and
that wasn't what I wanted to do. The week of exams has always felt a
bit overwhelming.  I usually set the last day of classes as a due date
for final project working prototypes at which point there are a few
days of peer review, then possible responses to peer review before
**final** final projects are due on the last day of exams. Then I have
under two days to evaluate all of the projects (there were 29 this
semester) and get final grades calculated and submitted.

This last round was probably the first time that I've made it through
the final couple days of intense grading without pulling my hair out,
spending precious time agonizing over how to distribute points, or
realize that I actually still had assignments from the semester in
need of grading. I owe this improvement in part to experience and
understanding the importance of getting all other assignment grades
done and recorded before starting to look at projects, but also in
part to the knowledge gained in Assessment Techniques in Engineering
Education (ENGE 5404), my first ENGE class which I completed this
semester.

As a bit of an afterthought assignment, after preparing and giving
final project presentations, we were asked to write a short paper
explaining the difference between assessment and evaluation.

We had been discussing assessment all semester long, and while I'm sure
we talked about what assessment was at some point, we hadn't really
discussed evaluation, how it is different from assessment and how the
two relate. The differences between the two are relatively straight
forward, as I found, but I gained something with that added clarity
that I think helped with the looming project evaluations I would be
buried under for the next couple days.

From [ABET](http://www.abet.org/eac-criteria-2014-2015/2):

> Assessment is one or more processes that identify, collect, and
> prepare data to evaluate the attainment of student
> outcomes. Effective assessment uses relevant direct, indirect,
> quantitative a and qualitative measures as appropriate to the
> outcome being measured. Appropriate sampling methods may be used
> as part of an assessment process.

> Evaluation is one or more processes for interpreting the data and
> evidence accumulated through as assessment processes. Evaluation
> determines the extent to which student outcomes are being
> attained. Evaluation results in decisions and actions regarding
> program improvement.

Or, the condensed version: the focus of assessment is to collect data
about *how* the teaching/learning process is functioning and using
that to improve while the goal of evaluation is to assign a number or
grade that represents *what* a student has learned (or how effectively
an instructor has taught).  Assessment is a formative activity, it
should be actively done throughout the semester, while evaluation is a
summative process, it aggregates data that has been collected and
turns it into something final.

Ok, so why am I spending so much time on this, when I wanted to talk
about how I ended up evaluating final projects? Well, grading has
never been something I look forward to. In fact, it's probably the one
part of teaching that I've really disliked. Some of my dislike I think
is just due to the nature of the task.  It tends to be repetitive. If
all the assignments are the same it can be boring, if all the
assignments are different it can be really challenging to come up with
a grading rubric that is consistent and fair.  There is always a part
of grading (especially final grades), that are subjective. It requires
a degree of confidence on the part of the grader to assign a number
that corresponds to how well a person has mastered material.
Especially in my early years of teaching, I was often self conscious
about final grades out of fear that my choices would be questioned, or
that while trying to be fair and consistent across a group of
students, I'd make a mistake, treat someone differently than someone
else, and be called out on it.

But I also don't like the finality of grades, especially final
grades. I feel its important to provide an opportunity to discuss work
that doesn't demonstrate proficiency and to make corrections and
resubmit it. The system I use for programming assignments allows for
continuous re-submissions (though it is far from perfect, in particular
it doesn't really encourage having a conversation with the instructor
about why something was incorrect, something I would like to address
in a future version), but there is limited opportunity to do something
similar with final project grades.

But another thing that writing about the differences between
assessment and evaluation brought to the forefront of my thoughts was
that while I don't particularly like evaluation, for the reasons
states, I actually enjoy assessment.  To me it is a much more
constructive, optimistic process. It's not about judging what someone
already knows, but about helping them learn more effectively, and that
is something that really interests me. I have spent a lot of time
thinking about and developing the system I currently use for homework
submissions in part because it saves me the drudgery of repeated
evaluation of programming assignments (and yes, in the context of the
assignment, this is an evaluation, though that data can and is used by
a larger assessment process), but also because I am experimenting with
how to provide more useful, real time feedback so that learners can
correct their own mistakes when it just isn't feasible in a class of
71 for me to have a conversation with each individual about every
stage of an assignment.  What I can do, is look at the data that is
generated by the automatic system, things like average completion
time, average score on the first submission, average number of
submissions before a perfect score, and even find the specific parts
of an assignment that were most challenging, and use that to mold the
direction we take in class discussions and future assignments. I think
that is a critical piece of effective teaching (though I am by no
means good at it yet!), and is one reason I tend to be critical and
skeptical of rigid lesson plans and lecture notes that haven't changed
in 10 years.

So ideally, I'd like to think of the data that I generate as a part of
evaluating final projects part of assessment, that is, I'd like to be
fairly critical and use a scale in which 100% means "I don't see any
obvious room for improvement" and having it be OK if the maximum score
is an 80%.  In an assessment scenario, a max score of 80% (or 60%, or
%40, etc.)  just means the instructor/learners need to rethink parts
of what they're doing to improve, the severity of the problem might
reflected in the actual value. As long as there is an opportunity to
improve I'm not too concerned about low maxes and low averages on a
particular assignment. Also, due to the size of the class and my own
time constraints, the final projects are the only assignments that I
am able to really read through every line of code and judge for things
like style, composition and technique. These are things I talk about
and show examples throughout the semester, but without getting regular
feedback I can't expect everyone to pickup on the many nuances and
reflect this in their code, so I want a way of saying "hey, this
program works as expected, but the code itself has a number of serious
problems", and I want that to be reflected in the final project score,
but I want a consistent mechanism in place so that that type of
response isn't detrimental to a students final grade in the course
since I know I wasn't able to provide feedback like that earlier in
the semester.

## A project evaluation method with a focus on assessment

All in all, I want to approach the final projects as an assessment
tool that allows me give honest, critical feedback, and an algorithm
for generating a final grade that takes into account the limitations
of the grading/feedback system used throughout the semester.  Here's
what I came up with.

First, I wrote up a number of statements I wanted to evaluate, modeled
after what I was asking for in the
[peer review assignment](https://computing.ece.vt.edu/~ece2524/activities/project_review/).

~~~ text
## Usage
- The README contained everything I needed to easily use the program.
- The program compiles/runs without errors.
- The program worked as advertised.

## Style
- The code is cleaning divided into modules and multiple files.
- Variable and function names are meaningful
- Comments are used where appropriate.

## Philosophy
- The program most closely follows the `` interface pattern.
- This choice of pattern is a good one for this application.
- This program follows the Rule of Silence and Least Surprise.
- This program follows the Rules of Modularity and Composition.
- This program follows the Rules of Representation and Simplicity.
~~~

I used a 4-point Likert scale for each item, values 1-4 corresponding
to "disagree", "slightly disagree", "slightly agree", and "agree". To
decouple my data entry from the feedback presentation, and to
facilitate number crunching, I entered the data in a YAML formatted
file for each project:

~~~ yaml
usage:
  readme: 
    score: ~     # [0-4]
    comment?: ~ 
  run:
    score: ~     # [0-4]
    comment?: ~
  worked:
    score: ~     # [0-4]
    comment?: ~
style:
  modules:
    score: ~     # [0-4]
    comment?: ~
  names: 
    score: ~     # [0-4]
    comment?: ~
  comments:
    score: ~     # [0-4]
    comment?: ~
philosophy:
  ui_pattern: 
    matches: ~   # (filter|cat-like|ed-like|compiler)
    score: ~     # [0-4]
    comment?: ~ 
  ui_choice:
    score: ~     # [0-4]
    comment?: ~
  silence_surprise:
    score:       # [0-4]
    comment?: ~   
  modularity_composition:
    score:       # [0-4]
    comment?: ~
  representation_simplicity:
    score:       # [0-4]
    comment?: ~
overall?: ~
~~~

Each item had a place for a comment which I used to explain my score
decision and often suggest improvements. The comments (text after the
`#` symbols, only served as a reminder to me of the format that data
should be in, though eventually I might think of a good way to use
something like that for automatic validation of data as I enter it.

The feedback was in the form of a peer review response, just like
other reviews left by other students. For example,
[my review](https://computing.ece.vt.edu/~ece2524/reviews/dmaczka/reviews/epenn28_textanalyser/review/)
of the [Text Analyzer project](https://github.com/epenn28/textanalyser).

The final piece, which reduced a lot of stress and made the experience
rather painless and even enjoyable was a bit of ruby code for generating a
final project grade:

~~~ ruby
def project_scores(data)
  scores = [ :usage, :style, :philosophy ].inject({}) { |result,key| result[key] = collect_scores(data[key.to_s]); result } 
  scores
end

def weighted_score(scores, weights)
  weights.zip(scores).inject(0) { |sum, (weight,value)| sum += weight*value }
end

def grade_scale(scores)
  [ 60, 30, 10 ].permutation(3).collect { |p| weighted_score(scores,p) }.max.round(2)
end

section_scores = [ 4*3, 4*3, 4*5].zip(scores.values).collect { |den, scores| scores.inject(0) { |r,s| r += s.to_f } / den }
final_grade = grade_scale(section_scores)
~~~

Scores are grouped into the three categories, "usage", "style", and
"philosophy", the average of each category is calculated producing an
array of three numbers, weights of 60%, 40% and 10% are assigned to
each category such that the final score is maximized.  Thus, the
poorest performing category will be weighted the least while the best
performing category will be weighted the most. A good score can still
be achieved even if there were serious problems in one of the
categories.

Having this in place allowed me to be more objective and consistent
with evaluating each item. In the past, when I had attempted similar
rubrics, but without a clear algorithm for generating a grade, my
scores would inconsistently become more subjective if I noticed my
responses for a number of items were negative, thinking to myself "the
simple sum of these numbers isn't going to accurately reflect what I
think a final score for this project should be, so maybe I'll be less
critical for some items."

Now, this current system is certainly not perfect, and there were
still moments of stressful subjectivity because I left out items like
"This program does one thing and one thing well" which would add an
extra dimension to account for really excellent, clearly defined ideas
but perhaps with a number of implementation issues, or "This program
was enjoyable and easy to use" which would add a dimension to capture
a bit of the hard work that was put into designing a good user
experience.
