---
name: Create New Branch
labels: 'issue: create new branch'
about: Report a new branch for curation such as for new OpenSSL release

---
Branch to be created: 

- [ ] 1. Create GitHub Issue
- [ ]       1.1 Add this template into the description of the Issue
- [ ] 2. Checkout New Upstream Version
- [ ] 3. Build and Test New Version, ensuring it builds with NO errors
- [ ] 4. Create The New Branch
- [ ] 5. Apply Build Changes
- [ ]   5.1. Add Intel Version Number
- [ ]   5.2. Add Intel Build Options
- [ ] 6. Build & Test w/ new changes, ensuring it builds with NO errors
- [ ] 7. Tag The Release
- [ ] 8. Push Changes & Close the GitHub Issue --> You can close the issue at this step, but remember to go back and complete the next steps.
- [ ]   8.1 Going through this checklist and ensuring you completed each task
- [ ] 9. Publishing The New Branch In The README.md On The Default Branch
- [ ]   9.1.1. EOL GitHub Milestones
- [ ]   9.1.2. Creating a new EOL GitHub Milestone
- [ ]   9.1.3. Add the information to the README
- [ ]   9.1.4. How to add a new primary/secondary version into the README
- [ ] 10.  Update the default-branch in intel-innersource/inventory
- [ ] 11.  Add new branch CPE to Hartwell.
- [ ]   11.1.1. Fork Hartwell
- [ ]   11.1.2. In your forked repo, create a new branch and name it "hartwell-{library}-addition"
- [ ]   11.1.3. Now commit the changes with a subject line "{library} {Version} added to {library}_versions.txt"
- [ ]   11.1.4.  Finally, open a pull request against Hartwell's master branch.

<!--
Thank you for your bug report.

This is for the common case where a new branch needs to be created.  The most common case for
this is the need to support a new release of OpenSSL.

For example, if OpenSSL releases 3.1.3, an openssl-3.1.3-Intel branch needs to be created.




-->