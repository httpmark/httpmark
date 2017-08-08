# Motivation

A couple of us were asked to profile the performance of a client's web application. We needed to do some research on existing tools. Our requirements were that the tool should offer:

* a private instance we can deploy at our convenience into existing cloud infrastructure
* a method of testing in the context of different geographical regions. This would allow us to find potential patterns in the application loading time associated with the access location and the location of where the origin is deployed, if the request isn't routed in the correct manner.
* at the **very minimum**, a 'waterfall view' of asset request/responses, so we can delve into the forensics of each asset transaction.
* access to the underlying [HAR](http://www.softwareishard.com/blog/har-12-spec/) blob so it can be archived on other storage mediums.
* an interface to allow for [scripted testing](https://github.com/httpmark/httpmark/issues/18)

We decided to use [WebPagetest](https://www.webpagetest.org/). We were able to deploy a private instance relatively easily to our existing AWS infrastructure using the [provided EC2 AMIs](https://sites.google.com/a/webpagetest.org/docs/private-instances) (although we made the process even easier by [offering them as Terraform bundle](https://github.com/redbadger/webpagetest-aws-terraform). We did however, come across issues. Below, we've described the motivations for this project, relative to WebPagetest.

## Guiding Principles Relative To WebPagetest

### Out-of-date UX

Clearly, not much UX though has gone into the current UI of WebPageTest. The current design:

* is difficult to use

#### Resolution

The httpmark UI will be engineered from the ground up to put the emphasis on great UX. In turn, this will make the platform as easy as possible to use.

### Manual Installation Of Private Instances

WebPageTest does offer private instances in the form of AWS AMIs but these still require setup. Whilst httpmark will offer both a public interface in which to launch tests from, the main 'sell' are private instances. Therefore the process of configuring those private instances should be as painless as possible.

We should aim for a one click deploy, by describing our entire infrastructure in code - using Terraform.

### Incredibly Slow Test Agent Startup Time

The time it takes from submitting a test run to the test agent playing that test, is unacceptably slow.

WebPageTest offers both a public interface as well as private instances in the form of AMIs The current process of running a test in a new region is:

The current process of running a test in a new region is:

1. Creation of an EC2 instance in that region
2. Installation of WPT driver on that instance.
3. Installation of the full suite of browsers, regardless of whether they have all been selected as test applicants.
4. Run the test(s).

This process can take upwards of 15 minutes.

The public interface does take a shorter amount of time for this process to happen, due to it's custom test instance infrastructure (i.e all instances are constantly warm). However, given httpmark's slightly differently target demographic, this scenario isn't entirely applicable.

#### Resolution

httpmark will:

* Use containers rather than virtual machines for it's test agents
* Proactively deploy the relevant infrastructure for test agents to every AWS region on initial installation (private instance)
* Containers will originate from an image where all the relevant drivers and dependencies are pre-installed.

### Test Agents

#### Reduce Invocation Latency Of Agent Creation

The process of the server dynamically spinning up a test agent instance takes ~15mins which is unacceptable. The initial setup includes installing browsers (even those that aren't needed within the scope of the test) and WPTDriver.

### Container-based Environments

Rather than relying on either AMIs or advocating manual server setup, both server and tests agents should be containerised.

### Reduce Subsequent Feedback Loop

Whilst the aforementioned step is being performed, there is no visual feedback to the user. We should implement real-time progress of test agent setup (and test run) by providing a stdout-style interface as well as streaming of the RDP client to the server.

### Implement Immutable Infrastructure

Apart from spinning up a pre-defined AMI, current WebPagetest documents advocate a manual server setup. For those who don't wish to use the SaaS, we should instead provide a consumable instance that can be deployed in an immutable fashion - i.e Terraform.

### Better Developer Experience

We should encourage active development of the platform. To aid this, the development tools should make the experience as painless as possible - i.e containerised development, HMR in both the client bundle and in Node.

* Adherence to [the testing triangle](https://martinfowler.com/bliki/TestPyramid.html) whenever possible; reliance on unit tests over integration tests wherever possible.
