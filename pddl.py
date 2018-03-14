class PDDL:
    from collections import defaultdict

    def __init__(self, domain=None, requirements=[], types=defaultdict(list), 
            constants=[], predicates=defaultdict(dict), actions=[]):
        self.domain = domain 
        self.requirements = requirements
        self.types = types
        self.constants = constants
        self.predicates = predicates
        self.actions = actions
    
    def save(self):
        with open(self.domain + ".pddl", "w+") as f:
            f.write("(")
            
            # Domain
            f.write('define (domain {})\n'.format(self.domain))

            # Requirements
            f.write("\t(:requirements \n")
            for requirement in self.requirements:
                f.write("\t\t :{}\n".format(requirement))
            f.write("\t)\n\n")

            f.write("\t(:types \n")
            for key in self.types:
                f.write("\t\t" + " ".join(self.types[key]) + " - " + key + "\n")
            f.write("\t)\n\n")

            # Predicates 
            f.write("\t(:predicates \n")
            for predicate in self.predicates:
                f.write("\t\t(" + str(predicate) + " ")
                predicate_string=""
                for argument_type in self.predicates[predicate]:
                    predicate_string += " ".join("?" + str(x) for x in self.predicates[predicate][argument_type]) + " - " + str(argument_type) + " "
                f.write(predicate_string[:-1])
                f.write(")\n")
            f.write("\t)")


            # end
            f.write("\n)")

pddl = PDDL()
pddl.domain="intersection"
pddl.requirements = ["equality", "negative-preconditions", "typing"]
pddl.types = {"object":["car", "loc"],
                "loc":["road", "spot"]}
pddl.predicates = {"clear":{"loc":["loc"]}, 
                   "at":{"car":["car"], "loc":["loc"]}, 
                   "adjacent":{}}
pddl.save()

def turn_action_generator(location, heading, bearing):


