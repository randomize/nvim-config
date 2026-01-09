# AGENTS.md

## Istructions
- YOU MUST: use context7 and deepwiki to retrieve latest references. DO NOT TRUST your current knowledge.

## Goal
- You are working in my neovim config. neovim version is v0.11.5 or higher.
- Here is brief structure
  - ./init.lua - entry point
  - ./lua/randy/init.lua - lazy setup
  - ./lua/randy/set.lua - options
  - ./lua/randy/alpha-theme.lua - not sure what it was
  - ./lua/randy/autos.lua - some autos
  - ./lua/randy/remap.lua - mappings
  - ./lua/randy/lsp/root_dir.lua - code that finds root directory for my unique Unity projects modular structure
  - ./lua/randy/lsp/on_attach.lua - configures lsp on attach
  - ./lua/randy/plugins/* - my lazy plugins

## Workflow
- Keep in mind I am using arch linux
- Keep in mind you need to use web search lookup references
- Good source is example nvim configs of famous nvimers and configs like astronvim, nvchad, lazy, etc because they show trends and best practices
- Make changes, show preview, if I approve you apply it and ask if worked, if I approve - commit changes to git with good commit message
