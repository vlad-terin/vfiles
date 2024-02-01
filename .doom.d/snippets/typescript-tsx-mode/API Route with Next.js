# -*- mode: snippet -*-
# name: Nextjs API Route
# key: napiroute
# --
import { NextApiRequest, NextApiResponse } from 'next';

export default (req: NextApiRequest, res: NextApiResponse) => {
  if (req.method === 'GET') {
    // Handle GET request
    res.status(200).json({ message: 'This is a GET request' });
  } else if (req.method === 'POST') {
    // Handle POST request
    res.status(200).json({ message: 'This is a POST request' });
  } else {
    // Handle any other HTTP method
    res.setHeader('Allow', ['GET', 'POST']);
    res.status(405).end(`Method ${req.method} Not Allowed`);
  }
};
