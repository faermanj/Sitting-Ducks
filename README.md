Welcome to the AWS CodeStar sample web service
==============================================

This sample code helps get you started with a simple Flask web service
deployed by AWS Elastic Beanstalk and AWS CloudFormation.

What's Here
-----------

This sample includes:

* README.md - this file
* buildspec.yml - this file is used by AWS CodeBuild to package your
  application for deployment to AWS Lambda
* requirements.txt - this file is used install Python dependencies needed by
  the Flask application
* setup.py - this file is used by Python's setuptools library to describe how
  your application will be packaged and installed
* sducks/ - this directory contains the Python source code for your Flask application
* tests/ - this directory contains unit tests for your application
* .ebextensions/ - this directory contains the configuration files that allow
  AWS Elastic Beanstalk to deploy your application
* template.yml - this file contains the description of AWS resources used by AWS
  CloudFormation to deploy your infrastructure


Getting Started
---------------

These directions assume you want to develop on your local computer, and not
from the Amazon EC2 instance itself. If you're on the Amazon EC2 instance, the
virtual environment is already set up for you, and you can start working on the
code.

To work on the sample code, you'll need to clone your project's repository to your
local computer. If you haven't, do that first. You can find instructions in the
AWS CodeStar user guide.

1. Create a Python virtual environment for your Flask project. This virtual
   environment allows you to isolate this project and install any packages you
   need without affecting the system Python installation. At the terminal, type
   the following command:

        $ virtualenv .venv

2. Activate the virtual environment:

        $ source ./.venv/bin/activate

3. Install Python dependencies for this project:

        $ pip install -r requirements.txt

4. Install the sample application code into your virtual environment:

        $ python setup.py install

5. Start the Flask development server:

        $ python sducks/application.py --port 8000

6. Open http://127.0.0.1:8000/ in a web browser to view the output of your
   service.

What Do I Do Next?
------------------

Once you have a virtual environment running, you can start making changes to
the sample Flask web service. We suggest making a small change to application.py first,
so you can see how changes pushed to your project's repository are automatically picked
and deployed to the Amazon EC2 instance by AWS Elastic Beanstalk. (You can watch the
progress on your project dashboard.) Once you've seen how that works, start developing
your own code, and have fun!

To run your tests locally, go to the root directory of the sample code and run
the `python setup.py pytest` command, which AWS CodeBuild also runs through
your `buildspec.yml` file.

To test your new code during the release process, modify the existing tests or
add tests to the tests directory. AWS CodeBuild will run the tests during the
build stage of your project pipeline. You can find the test results
in the AWS CodeBuild console.

Learn more about AWS CodeBuild and how it builds and tests your application here:
https://docs.aws.amazon.com/codebuild/latest/userguide/concepts.html

Learn more about AWS CodeStar by reading the user guide. Ask questions or make
suggestions on our forum.

User Guide: http://docs.aws.amazon.com/codestar/latest/userguide/welcome.html
Forum: https://forums.aws.amazon.com/forum.jspa?forumID=248

Best Practices: https://docs.aws.amazon.com/codestar/latest/userguide/best-practices.html?icmpid=docs_acs_rm_sec

How Do I Add Template Resources to My Project?
------------------

To add AWS resources to your project, you'll need to edit the `template.yml`
file in your project's repository. You may also need to modify permissions for
your project's worker roles. After you push the template change, AWS CodeStar
and AWS CloudFormation provision the resources for you.

See the AWS CodeStar user guide for instructions to modify your template:
https://docs.aws.amazon.com/codestar/latest/userguide/how-to-change-project#customize-project-template.html
