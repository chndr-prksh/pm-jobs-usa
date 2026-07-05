"""
Push the current SYSTEM_PROMPT (from create_agent.py) as a new version of
the existing agent. Agents are immutable per version — this creates version
N+1 rather than editing version N in place.

Run: python3 update_agent.py
"""

import os

from anthropic import Anthropic
from dotenv import load_dotenv

from create_agent import build_system_prompt

load_dotenv()


def main():
    client = Anthropic(api_key=os.environ["ANTHROPIC_API_KEY"])
    agent_id = os.environ["ANTHROPIC_AGENT_ID"]

    current = client.beta.agents.retrieve(agent_id)
    updated = client.beta.agents.update(
        agent_id,
        version=current.version,
        system=build_system_prompt(),
    )
    print(f"Agent {agent_id} updated: version {current.version} -> {updated.version}")


if __name__ == "__main__":
    main()
