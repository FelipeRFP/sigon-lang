package br.ufsc.ine.agent.context.custom;

import java.util.ArrayList;
import java.util.List;

import alice.tuprolog.InvalidTheoryException;
import alice.tuprolog.MalformedGoalException;
import alice.tuprolog.SolveInfo;
import alice.tuprolog.Theory;
import br.ufsc.ine.agent.bridgerules.Body;
import br.ufsc.ine.agent.bridgerules.BridgeRule;
import br.ufsc.ine.agent.bridgerules.Head;
import br.ufsc.ine.agent.context.ContextService;
import br.ufsc.ine.agent.context.beliefs.BeliefsContextService;
import br.ufsc.ine.agent.context.communication.CommunicationContextService;
import br.ufsc.ine.agent.context.desires.DesiresContextService;
import br.ufsc.ine.utils.PrologEnvironment;

public class CustomContext  implements ContextService {

    protected String name;
    protected PrologEnvironment prologEnvironment;

    public CustomContext(String name){
        this.name = name;
        prologEnvironment = new PrologEnvironment();
    }

    @Override
    public Theory getTheory() {
        return  prologEnvironment.getEngine().getTheory();
        
    }
    
    public List<BridgeRule> callRules() {
		return null;
	}
    
	public void printBeliefs() {
		System.out.println(this.getName()+":");
		System.out.println(prologEnvironment.getEngine().getTheory().toString().trim());
		System.out.println("-------------------------------");
		
	}
	
    @Override
    public boolean verify(String fact) {
        SolveInfo solveGoal;
        try {
            solveGoal = prologEnvironment.solveGoal(fact);
            return solveGoal.isSuccess();
        } catch (MalformedGoalException e) {
            return false;
        }
    }

    @Override
    public void appendFact(String fact) {
        try {
            prologEnvironment.appendFact(fact);
        } catch (InvalidTheoryException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void addInitialFact(String fact) throws InvalidTheoryException {

    }

    @Override
    public String getName() {
        return this.name;
    }
    
    
    
}
