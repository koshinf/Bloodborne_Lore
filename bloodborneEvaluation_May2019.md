# Bloodborne Lore Project Review

Site publication: <http://bloodborne.newtfire.org/>

GitHub: <https://github.com/koshinf/Bloodborne_Lore>

Developers: 
* Frank Koshinskie: @koshinf
* Nathan Dietz: @NADGIT
* Donald Denne: @SparkTheDragon

Date of Evaluation: 2019-05-15
Evaluated by: Elisa Beshero-Bondar: @ebeshero


### General  
*Bloodborne Lore* is an impressive project to compile and organize coherent information about a game world that is notoriously difficult for its players to understand and navigate. This project succeeds in compiling a helpful interactive database keyed to a map of the game, and begins investigating linguistic patterns in the game as well. This work seems worth continuing perhaps in a new phase of the project.

### Research questions
Your project does not announce itself on its main page to be a site about game research, but it does contribute analytical data about language and characters in *Bloodborne Lore*. 

When we worked on the network analysis stage of the course, the data we were able to network from your files helped to form an interesting linguistic investigation of the game lore, since we were able to tell how frequently certain phrases and motifs were shared in locations and among key characters. The team began to explore these questions in the portion of the site marked as “TSV Collection”, representing the tab-separated values files that you prepared of the network data. Suggestions here:

Label this section something more informative about its content, perhaps “Game language” or “Character networks”, since the TSV data format is not really very helpful in conveying an idea of the content. 
This section could use some work. It is a good start on investigating patterns in your data, but it needs more than headings to describe the patterns we see in the visuals. (You want at least a paragraph for each visualization you include.) And the visuals themselves could be made clearer and broken into sub-networks for clarity to help guide readers in how to understand things like size of the nodes, clusters of data. (More on this below in the review.)

Every visualization is limited in some way, missing some information in its source, so tell us what something about the limits of these networks and what is most reliable and interesting about them. For example, could there be missing or ambiguous data in the markup that might be interpreted a different way? 

### Schema modeling 
Your team, especially Frank, worked hard on defining a most impressively detailed XML data model in your Relax NG schema. It was important at one point to ensure every team member was applying that schema, and when the team pulled together on this, it seems to have succeeded in the compilation of the mainXML document containing the full assemblage of your game lore.

I am sorry that we did not have a chance to review a Schematron file that evidently was not working, however. It was the a very useful idea, to ensure that the text content of a `<location>` element matched text tokens in its `@place`, but it needed some fine-tuning. I pushed some repairs to that file for you to test and consider here with this commit:  <https://github.com/koshinf/Bloodborne_Lore/commit/c996b6a1a2ebebcbf3ccf2876335bf12bc1a3a99>

### Technologies for visualization 
#### Image Mapping and Saxon JS (XSLT in the browser)
Your image mapping of Yharnam makes the map an interactive source of detailed data about items to be found in each location. This is certainly the project’s most impressive accomplishment in data visualization, and a central goal of the team from the project’s inception. It was exciting to follow Nathan’s adventurous work with Saxon JS in developing this map interface, and that implementation makes it easy for this project to continue growing easily, since you can now easily just correct and update your XML, push it to the server, and on click of the map, XSLT runs “live,” dynamically in the browser, to update the information viewable on the page. Basically, Saxon JS makes it possible to treat our Apache server like our eXist XML database, only accessing the data with XSLT rather than XQuery. This was a fascinating test of what is possible with XML technologies running the web browser. 

#### Network graphs
The networks are not so easy to access as your image map, for reasons partly discussed above. Network graphs are generally challenging to read, and you want to spend more time with this portion of the project site to help guide the visitor and help make the graphs more legible. Perhaps adapting the JavaScript magnifying glass that @frabbitry developed for the Ulysses project (see http://ulysses.newtfire.org/7EcclesStreet.html for example), would help here, but when data is densely concentrated in a graph like this, you really want to “unpack” the information piece by piece. Showing an overview of all the data at once is okay to survey a pattern from a distance, but each graph wants some filters as well as some serious discussion. You might also (as we advised the Ulysses team) simply provide a table in your HTML so people can read the nodes, see them ranked, say, in order of degree, etc. It is all good and well to label your distant view about key words, but you should also make it possible for us to read what they are, whether inside the graph or outside it. (Even on maximum zoom in Chrome on my Mac, I am not able to read your node labels on the top two graphs.)

You did provide one helpfully filtered view in your graph of NPC Gehrman’s keywords. This raised a good question from the audience in Pittsburgh when you presented your work. What does the word "ONE" indicate? We were impressed with Nathan’s prompt answer to this question, that it was not just a pronoun but rather a major named entity in the game lore. But that begs a question: if you are going to provide abbreviated strings representing these common words, you need to define them in a legend or glossary somewhere on this page to help us undertand what we are reading. 

###  “UX”: User Experience and Site Interface
The website is cleanly coded and validates with the w3c HTML standard, though you could add @lang="en" tags to all the pages for consistency. The navigation is usually consistent, though the banner may be most appropriate on the main page and not necessary elsewhere on the site, since it requires the visitor to scroll down to read content or to view the networks. Having a large illustrative image on same page as a series of infographics is a little awkward, so we recommend simplifying the design of the internal pages. 

The most serious UX problem is with the image map page, <http://bloodborne.newtfire.org/map.html>, where the site’s nav bar has mostly disappeared. I take some responsibility for this because it reflects a CSS hack I implemented when Nathan and Donald visited me in my office working on details of the project site. My hack was meant to be temporary just to demonstrate that pulling the map higher up the screen would help reveal what happens on click, since part of the iframe showing the database is now visible beneath it. That said, this does demand more attention and other solutions are certainly available. One solution to consider is moving the site navigation bar to one side and oriented vertically on just that page. Another is simply to keep tinkering with the amount of screen “real estate” taken by the image map. And yet another option (perhaps the least satisfying) may be to leave this design as it is, but change the top menu bar: only one value is visible on it, leading to the Team. You might change that so only the main page is available. I am happy to work with you on this to improve the design of this page so it better fits an otherwise meticulously designed website.


### GitHub and project management
File management is a challenge in team projects (tell us about it). Your team had some setbacks when not all members were deploying the project schema, and we suspect lines of communication and more regular project meetings would have resolved this. Nevertheless, each of you respected the file space and coordinated with each other as you individually experimented in areas of interest. GitHub’s commit activity (<https://github.com/koshinf/Bloodborne_Lore/graphs/commit-activity>) shows a peak of work toward the end of March and early April as the team worked to repair its XML base and build the website. 

At this point, following the semester’s code sprint, you may want to clean up some files that surely are misplaced at the top level of the repo (a stray image file and a blank text file). Otherwise the codebase is well organized. We would be very grateful to see you add some additional markdown files (beyond the impressively well-developed README on your repo), to call attention to unusual aspects of your code base: What should team members and people learning the XML stack know about Nathan’s implementation of SaxonJS and where can they find examples? That’s one thing you might discuss. Another might me a discussion of which files were involved in the image mapping and what approaches you took with designing the Map of Yharnam.  

### Closing Comments
While we took some time to point out some problems with the site interface and some areas in need of development, we *do* realize this is a work in progress. What the team produced inside a busy semester for each of you is most impressive and this has the makings of a highly professional website, and we hope you will be interested in revising and developing it thanks to the strong codebase you developed here. I am happy to meet with you to provide further guidance and support, and I hope the site becomes a major resource to *Bloodborne Lore*’s fan base and beyond! 

